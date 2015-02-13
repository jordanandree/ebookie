# Creating Templates and Campaigns

Once your list and forms are set up, you’re ready to start building an email message to send out to your subscribers. There are lots of names for this email—newsletter, blast, or e-shot just to name a few—but at MailChimp, we call each email message that you design and send to your subscribers a “campaign”. [Each campaign is built using a preset layout called a “template.”](http://kb.mailchimp.com/campaigns/ways-to-build/templates-vs-campaigns)

In this section, we’ll cover the basics of importing or coding a custom template into MailChimp. If you’d prefer to use MailChimp’s built-in selection of templates to create a campaign, feel free to skip ahead to the _Creating a Campaign_ section.

## Creating or importing a custom template

MailChimp provides a variety of customizable _Basic_ Templates and predesigned Template _Themes_ that can be used as starting points for email campaigns, but you’re not limited to those options. If you’d like to import your own templates or [create custom coded templates](http://eepurl.com/hcJp) to help fill a specific design or branding need, just visit the **Templates** section of your account and click the **Create Template** button. Here, you’re able to [paste in your own custom coded design](http://kb.mailchimp.com/campaigns/ways-to-build/paste-html-to-create-campaign) or upload templates from an [HTML](http://kb.mailchimp.com/templates/code/import-an-html-template) or [ZIP](http://kb.mailchimp.com/templates/code/import-a-zip-file-to-create-a-template) file. If you’d like to use one of our existing templates as a base for your custom design, you can do that here as well. Any templates that you create here will be found under the **Saved Templates** tab when you reach the Template step of the Campaign Builder.

**Note**: To allow use of our visual content editing tools, you will need to code your templates using the [MailChimp Template Language](http://templates.mailchimp.com/getting-started/template-language/).

## Creating a campaign

The MailChimp campaign builder walks you through building a campaign, step by step. When it's time to design your campaign, if you're not using an uploaded template, you'll find a variety of basic email layouts you can customize easily without HTML knowledge. Many of our layouts use a drag and drop editor, which makes it easy to add, move, delete, and style content blocks. If you want to use the same layout again later, you can save your design as a template for future campaigns.

To get started, click the **Create Campaign** button from the **Dashboard** or **Campaigns** tab, and choose the type of campaign you’d like to create.

![](02-getting-started.png)

- **Regular Ol’ Campaigns** are the most common type of HTML email our users send. You can design and customize the designed HTML and plain-text versions of these emails, and choose whether to send them immediately or schedule them for later.

- [**Plain-Text Campaigns**](http://eepurl.com/gYYY) are the simplest form of mass email you can send. As the name suggests, these campaigns will only contain text, and have no formatting options.

- [**A/B Split Campaigns**](http://eepurl.com/hcvL) are a great tool for testing subject lines, From names, sending times, or—[when combined with the \*|GROUP:X|\* merge tag](http://kb.mailchimp.com/campaigns/ab-split/test-content-with-an-a-b-split-campaign)—even content. We'll send two different versions of the email to small portions of your list, track their performance, then send the "winning" version to all remaining subscribers.

- [**RSS-Driven Campaigns**](http://eepurl.com/iDlQ) allow you to automate your email marketing by combining content from an RSS feed with user-friendly MailChimp templates. Like the other campaign types, you can control when these campaigns go out and who receives them.

If you'd like to create a series of automated emails, check out our robust [**Automation**](http://mailchimp.com/features/automation/) features. Our [Working With Automation guide](http://mailchimp.com/resources/guides/working-with-automation/) will help you get started.

For now, we'll work with the **Regular Ol' Campaign**. The steps in the campaign builder will vary slightly across other campaign types, but the general behavior of templates will remain the same.

After you choose your campaign type, you’ll begin the campaign building process. In a **Regular Ol’ Campaign**, the first step is **Recipients**. Here, you’ll determine which subscribers will receive the campaign. You can choose to send it to the entire list, or use our segmentation tools to send targeted content based on subscriber data, campaign or e-commerce activity, group membership, manual selection, and more.

[This article](http://eepurl.com/gWN5) contains a quick tutorial on building segments and provides a full list of the available segmenting options.

In the **Setup** step, you’ll decide on a name for the campaign (this will not be visible in the sent campaign) and enter general information like the email subject, From name, and From email address. You’ll also have the option to set up our [Conversations](http://kb.mailchimp.com/lists/managing-subscribers/set-up-and-use-conversations) feature to help manage replies and to personalize the “To:” field of your campaign through the use of merge tags.

![](01-getting-started.png)

**Note:** If the associated list contains the names of your subscribers, checking the “Personalize the To: field” feature will allow you to use merge tags to help personalize each email. For example, \*|FNAME|\* \*|LNAME|\* would display as “To: John Smith” instead of “To: john.smith@domain.com.” Not only are personal emails more likely to be opened, they're also less prone to get flagged by spam filters.

Also included on the Setup step are a number of [native and third-party tracking options](http://eepurl.com/Bn9fz), the ability to enable automatic sharing of your campaign on [Facebook](http://eepurl.com/l7WJT) and [Twitter](http://eepurl.com/ko421), and [authentication](http://kb.mailchimp.com/delivery/deliverability-research/set-up-mailchimp-authentication).

Next up is the **Template** step. MailChimp offers a variety of basic templates and themes in each account.

Basic templates provide you with a highly-customizable blank layout, so you can easily add your own styles and content using the drag and drop functionality of our Email Designer. The following basic layouts are available:

- 1 Column
- 1 Column - Banded
- 1:2 Column
- 1:2 Column - Banded
- 1:3 Column
- 1:3 Column - Banded
- 2 Column
- 2 Column - Banded
- 2:1 Column
- 2:1 Column - Banded
- Left Sidebar Layout
- Right Sidebar Layout
- Simple Text
- Basic RSS (RSS-Driven Campaigns only)
- Right Sidebar RSS (RSS-Driven Campaigns only)

The only difference between non-banded and banded templates is their appearance. Non-banded templates are one solid color and have a defined border. Banded templates will have a “band” of color that stretches across the page and contains the footer information.

Themes, on the other hand, are predesigned, preconfigured templates that don’t require any programming or design knowledge to use. Simply pick a theme, plug in your content, and you’ll have a beautiful campaign. Themes come in two varieties: “drag and drop” and “classic.” Drag and drop themes offer functionality similar to that of basic templates, while only the color and content of the classic templates will be editable within MailChimp's email designer. The template type will be displayed below each theme, so you can easily differentiate between the two.

You also have the option to use **Saved Templates**, reuse layouts from drafted and recently sent **Campaigns**, or upload a template/paste in your own custom code from the **Code Your Own** tab.


## Add your content

Once you've selected a template, proceed to the **Design** step. Here, you’ll use MailChimp's email designer to add, rearrange, duplicate, and delete content blocks to create a unique campaign that is fully customized to your needs. You can modify and style the content for specific content blocks using the **Content**, **Style**, and **Settings** tabs in the editor.

Choose from the following content blocks:

- Text
- Boxed Text
- Image Group
- Image Card
- Image + Caption
- Image
- Divider
- Social Follow
- Social Share
- Button
- Footer
- Code
- RSS Header (RSS-Driven Campaigns only)
- RSS Items (RSS-Driven Campaigns only)

In each content block, you can add and format text, upload images, link to files, and further tailor the layout for maximum flexibility and personalization using the editor toolbar. After you've added content, the blocks can be dragged vertically or horizontally within the template to mix up the layout and design. Click the upper lefthand corner to drag each block up, down, or sideways as needed.

Will you have multiple users editing a campaign at the same time? No problem. With our [collaboration](http://eepurl.com/yM_M5) features, team members can watch each other edit copy and make design changes in real-time, with no refreshing needed. They’ll also be able to send test emails, solicit feedback, and leave comments right in the editor.


## Merge tags

In the **Setup** step, we used merge tags to personalize the “To:” field of the email. They can also help you add a personal touch to response emails, automation workflows, and regular campaigns. Merge tags are designed to pull in personalized or dynamic data from your list or MailChimp account and can be used for an array of different tasks. Whether you want to greet each subscriber by their first name in the email, populate RSS or social media information, translate content in a campaign, populate unique coupon codes or links for each subscriber, or include/exclude content within each email based on a subscriber’s profile information, merge tags help simplify the process.

For full tutorials on using MailChimp's merge tags and a list of all available merge tags, consult the following KB articles:

[Getting Started with Merge Tags](http://eepurl.com/cjSwb)

[All the Merge Tags Cheat Sheet](http://eepurl.com/cBqRg)

[How Conditional (or Smart) Merge Tags Work](http://eepurl.com/hcV)

[Smart Merge Tags and Groups](http://eepurl.com/BZv3)

[Troubleshooting Merge Tags](http://eepurl.com/hcrI)


## Keyboard shortcuts

We've added some handy keyboard shortcuts to make editing your content even easier:

- ESC - Save and close editor, hide preview
- CTRL + 1 - Toggle Preview mode
- CTRL + 2 - Send a test email
- CTRL + 3 - Push to MailChimp Mobile
- CTRL + ? - Show/hide hotkeys cheatsheet


## Text editor shortcuts

Use the ⌘ (Mac) or Ctrl (Windows) key on your keyboard for editor-specific shortcuts.

- ⌘ + Z - Undo action
- ⌘ + Y - Redo action
- ⌘ + L - Add link
- ⌘ + B - Bold selected text
- ⌘ + U - Underline selected text
- ⌘ + I - Italicize selected text


## Customize the design

The **Page**, **Preheader**, **Header**, **Body**, **Columns**, and **Footer** options (located in the **Design** tab) allow you to adjust colors, borders, text alignment, fonts, and link styles for each respective section of your campaign.

The [Mobile Styles](http://kb.mailchimp.com/campaigns/design/edit-and-test-mobile-styles-in-a-campaign) option will help you optimize the layout for mobile devices. You can use the mobile options to tweak font styles and improve the mobile experience of your campaign.

Finally, select [MonkeyRewards](http://kb.mailchimp.com/accounts/account-setup/add-or-remove-monkeyrewards) to pick a different badge design, or, [if you have a paid account](http://kb.mailchimp.com/accounts/account-setup/monkeyrewards-credits), to toggle the badge on and off.

Once you're satisfied with the styles you've picked, click **Save** to apply your changes.


## Preview and test your campaign

The [Preview and Test](http://eepurl.com/hcYK) menu houses all of our in-app campaign testing features. From this menu, you’ll be able to access _Preview Mode_, which will give you an idea how your campaign will render on desktop and mobile environments.

**Note:** If you're using merge tags in your campaign, you’ll find they're replaced with placeholder text when you view the campaign in **Preview Mode**. These placeholders let you know that the merge tags are working properly and will be replaced with subscriber-specific information when you send the campaign. To preview subscriber-specific information before a campaign is sent, follow the instructions described [in this article](http://eepurl.com/hcHX).

From the **Preview and Test** menu, you’ll also be able to send test emails to any email address you’d like, [preview the mobile version of your campaign directly from your mobile device](http://kb.mailchimp.com/campaigns/design/edit-and-test-mobile-styles-in-a-campaign#Push-to-MailChimp-Mobile), use the Link Checker to make sure that all links in your campaign are valid, or set up [Social Cards](http://eepurl.com/XSaMn) for your campaign. When enabled, Social Cards will give you the opportunity to choose a featured image and snippet of text that appears when your campaign is shared by anyone on Facebook and Twitter, or when viewed in Gmail’s grid view.

The final testing tool available in the **Preview and Test** menu is our [**Inbox Inspector**](http://eepurl.com/gOOb). This feature automates the testing process and provides you with renderings of the campaign as they will appear across multiple email clients with just a few clicks. It can also run spam filter checks on the content to help identify potential red flags in your campaign. Inbox Inspector is free for all users with monthly paid accounts—up to 25 inspections can be run each week at no cost. Users with free and pay-as-you-go plans can purchase a single Inbox Inspection for $3.


## Sending your campaign

Once you've finished designing your campaign, you’ll navigate to the **Confirm** page—the final step of the campaign building process. Here, we’ll scan the campaign to make sure that all of the previous steps have been properly completed and alert you to anything that might need your attention before sending. Here you can also preview both the HTML version and the automatically generated plain-text copy of the campaign one last time, run a final Inbox Inspection, or send one last test email to make sure everything is just right.

When you’re ready to send, there are several different delivery methods available. All users have the option to send the campaign immediately or to [schedule it for a specific date and time](http://eepurl.com/ij5r). Users with paid accounts will have 3 additional scheduling features to choose from as well:

- [Send Time Optimization](http://kb.mailchimp.com/deliverability/deliverability-research/find-your-best-sending-time) analyzes the activity history of the subscribers in your list to determine and distribute the campaign at the optimal sending time.

- [Time Warp](http://kb.mailchimp.com/campaigns/confirmation-and-sending/use-timewarp-to-optimize-sending-by-time-zone) delivers the campaign to your list based on the recipient's time zone, rather than the time zone selected in your MailChimp account.

- With [Batch Delivery](http://kb.mailchimp.com/campaigns/confirmation-and-sending/schedule-batch-delivery), rather than sending your campaign out to the whole list at once, this feature will send the campaign in timed batches.
