package handler;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.simpleemail.AmazonSimpleEmailService;
import com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceClientBuilder;
import com.amazonaws.services.simpleemail.model.Body;
import com.amazonaws.services.simpleemail.model.Content;
import com.amazonaws.services.simpleemail.model.Destination;
import com.amazonaws.services.simpleemail.model.Message;
import com.amazonaws.services.simpleemail.model.SendEmailRequest;
import org.springframework.http.HttpStatus;
import java.util.Map;

public class LambdaHandler implements RequestHandler<Map<String,String>, String> {

    private static final String SUBJECT                 = "Activation email BCC";
    private static final String EMAIL_BODY              = "You username is %s and temporary password is %s.";
    private static final String CHARSET                 = "UTF-8";
    private static final String SOURCE                  = "support+dev@book-nook-learning.com";
    private static final String USER_EMAIL_PROPERTY     = "email";
    private static final String USER_PASSWORD_PROPERTY  = "password";
    private static final String ADDRESSEE_PROPERTY      = "addressee";

    @Override
    public String handleRequest(Map<String, String> event, Context context) {
        String email = event.get(USER_EMAIL_PROPERTY);
        String password = event.get(USER_PASSWORD_PROPERTY);
        String addressee = event.get(ADDRESSEE_PROPERTY);
        if (email.isEmpty() || password.isEmpty() || addressee.isEmpty()) {
            return HttpStatus.BAD_REQUEST.toString();
        } else {
            sendEmailCopy(email, password, addressee);
            return HttpStatus.OK.toString();
        }
    }

    private void sendEmailCopy(String email, String password, String addressee) {
        AmazonSimpleEmailService emailService = AmazonSimpleEmailServiceClientBuilder.standard()
                .withRegion(Regions.US_EAST_1)
                .build();
        SendEmailRequest request = new SendEmailRequest()
                .withDestination(new Destination().withToAddresses(addressee))
                .withMessage(new Message()
                        .withBody(new Body()
                                .withText(new Content()
                                        .withCharset(CHARSET)
                                        .withData(String.format(EMAIL_BODY, email, password))))
                        .withSubject(new Content()
                                .withCharset(CHARSET)
                                .withData(SUBJECT)))
                .withSource(SOURCE);
        emailService.sendEmail(request);
    }
}