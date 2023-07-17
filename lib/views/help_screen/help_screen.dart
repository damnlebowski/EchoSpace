
import 'package:echospace/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgBlack,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: kWhite,
            )),
        title: const Text(
          'Help',
          style: TextStyle(color: kWhite),
        ),
        backgroundColor: kBgBlack,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            'Welcome to EchoSpace Help',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Account Setup and Basics',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Creating an Account',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'To join the EchoSpace community, follow these simple steps:\n'
            '1. Download the EchoSpace app from the App Store or Google Play Store.\n'
            '2. Open the app and tap on "Sign Up" to create a new account.\n'
            '3. Fill in the required information, such as your name, email address, and a secure password.\n'
            '4. Agree to our Terms of Service and Privacy Policy.\n'
            '5. Tap "Create Account" to finish the registration process.',
            style: TextStyle(color: kWhite),
          ),
          SizedBox(height: 16.0),
          Text(
            'Logging In',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'If you already have an EchoSpace account, follow these steps to log in:\n'
            '1. Open the EchoSpace app.\n'
            '2. Tap on "Log In" and enter your registered email address and password.\n'
            '3. Tap "Log In" to access your account.',
            style: TextStyle(color: kWhite),
          ),
          SizedBox(height: 16.0),
          Text(
            'Navigating the App',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'EchoSpace provides a user-friendly interface to help you effortlessly explore its features. Here\'s a quick overview of the main sections:\n'
            '- Feed: Discover the latest updates from users you follow and explore trending content.\n'
            '- Profile: Access and manage your own profile, including posts, followers, and settings.\n'
            '- Explore: Explore content from various categories and find new users to follow.\n'
            '- Notifications: Stay informed about likes, comments, and new followers.\n'
            '- Direct Messages: Connect with other users privately through messaging.',
            style: TextStyle(color: kWhite),
          ),
          SizedBox(height: 16.0),
          Text(
            'Features and Functionality',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Posting Content',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'To share your thoughts, photos, or videos with the EchoSpace community, follow these steps:\n'
            '1. Tap on the "+" button located at the bottom center of the app.\n'
            '2. Choose the content type you want to post, such as text, photo, or video.\n'
            '3. Add captions or descriptions to accompany your post.\n'
            '4. Optionally, include hashtags to make your post discoverable to a wider audience.\n'
            '5. Tap "Post" to share it with your followers.',
            style: TextStyle(color: kWhite),
          ),
          SizedBox(height: 16.0),
          Text(
            'Interacting with Content',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'EchoSpace allows you to engage with posts in various ways:\n'
            '- Liking: Tap the heart-shaped icon to show appreciation for a post.\n'
            '- Commenting: Share your thoughts and start conversations by leaving comments.\n'
            '- Sharing: Repost interesting content to your own profile or with specific friends.\n'
            '- Saving: Bookmark posts you find interesting to access them later in your Saved section.',
            style: TextStyle(color: kWhite),
          ),
          SizedBox(height: 16.0),
          Text(
            'Discovering Content and Users',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'EchoSpace offers several features to help you discover content and connect with other users:\n'
            '- Explore Categories: Swipe through different categories to find content tailored to your interests.\n'
            '- Trending Hashtags: Check out the popular hashtags to explore relevant posts and trends.\n'
            '- Recommended Users: Receive personalized recommendations for new users to follow based on your interests.',
            style: TextStyle(color: kWhite),
          ),
          SizedBox(height: 16.0),
          Text(
            'Privacy and Security',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'At EchoSpace, we prioritize your privacy and security. Here are some key points to keep in mind:\n'
            '- Privacy Settings: Customize your privacy settings to control who can see your posts, like, and comment on them.\n'
            '- Block and Report: If you encounter any unwanted or abusive behavior, use the block and report features to keep your experience safe.\n'
            '- Data Protection: We take data protection seriously and ensure your personal information is encrypted and handled in accordance with our Privacy Policy.',
            style: TextStyle(color: kWhite),
          ),
          SizedBox(height: 16.0),
          Text(
            'Getting Help',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: kWhite,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'If you encounter any issues or have questions about EchoSpace, here are the resources available to assist you:\n'
            '- Help Center: Visit our comprehensive Help Center for FAQs, troubleshooting guides, and other useful information.\n'
            '- Contact Support: If you need further assistance, you can reach out to our support team via [email/phone/support portal].\n'
            '- Community Forums: Join the EchoSpace community forums to engage with other users, share tips, and ask for advice.',
            style: TextStyle(color: kWhite),
          ),
        ],
      ),
    );
  }
}
