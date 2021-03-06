/* GMCodeInjector.m created by Lukas Pitschl (@lukele) on Fri 14-Jun-2013 */

/*
 * Copyright (c) 2000-2013, GPGTools Team <team@gpgtools.org>
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of GPGTools nor the names of GPGMail
 *       contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE GPGTools Team ``AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE GPGTools Team BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "CCLog.h"
#import "GPGMail_Prefix.pch"
#import "JRLPSwizzle.h"
#import "GMCodeInjector.h"

@implementation GMCodeInjector

+ (NSDictionary *)commonHooks {
	return @{
			 @"MessageHeaderDisplay": @[
					 @"_attributedStringForSecurityHeader",
					 @"textView:clickedOnLink:atIndex:"
			 ],
			 @"ComposeBackEnd": @[
					 @"_makeMessageWithContents:isDraft:shouldSign:shouldEncrypt:shouldSkipSignature:shouldBePlainText:",
					 @"canEncryptForRecipients:sender:",
					 @"canSignFromAddress:",
					 @"recipientsThatHaveNoKeyForEncryption",
					 @"setEncryptIfPossible:",
					 @"setSignIfPossible:",
					 @"_saveThreadShouldCancel",
					 @"_configureLastDraftInformationFromHeaders:overwrite:",
					 @"sender"
			 ],
			 @"HeadersEditor": @[
					 @"securityControlChanged:",
					 @"_updateFromAndSignatureControls:",
					 @"changeFromHeader:",
					 @"dealloc",
					 @"awakeFromNib",
					 @"_updateSignButtonTooltip",
					 @"_updateEncryptButtonTooltip",
					 @"updateSecurityControls",
					 @"_updateSecurityStateInBackgroundForRecipients:sender:"
			 ],
			 @"MailDocumentEditor": @[
					 @"backEndDidLoadInitialContent:",
					 @"dealloc",
					 @"backEnd:didCancelMessageDeliveryForEncryptionError:",
					 @"backEnd:didCancelMessageDeliveryForError:"
			 ],
			 @"NSWindow": @[
					 @"toggleFullScreen:"
			 ],
			 @"MessageContentController": @[
					 @"setMessageToDisplay:"
			 ],
			 @"BannerController": @[
					 @"updateBannerForViewingState:"
			 ],
			 @"Message": @[],
			 @"MimePart": @[
					 @"isEncrypted",
					 @"newEncryptedPartWithData:recipients:encryptedData:",
					 @"newSignedPartWithData:sender:signatureData:",
					 @"verifySignature",
					 @"decodeWithContext:",
					 @"decodeTextPlainWithContext:",
					 @"decodeTextHtmlWithContext:",
					 @"decodeApplicationOctet_streamWithContext:",
					 @"isSigned",
					 @"isMimeSigned",
					 @"isMimeEncrypted",
					 @"usesKnownSignatureProtocol",
					 @"clearCachedDecryptedMessageBody"
			 ],
			 @"MimeBody": @[
					 @"isSignedByMe",
					 @"_isPossiblySignedOrEncrypted"
			 ],
			 @"MessageCriterion": @[
					 @"_evaluateIsDigitallySignedCriterion:",
					 @"_evaluateIsEncryptedCriterion:"
			 ],
			 @"Library": @[
					 @"plistDataForMessage:subject:sender:to:dateSent:remoteID:originalMailbox:flags:mergeWithDictionary:",
			 ],
			 @"MailAccount": @[
					 @"accountExistsForSigning"
			 ],
			 @"OptionalView": @[
					 @"widthIncludingOptionSwitch:"
			 ],
			 @"NSPreferences": @[
					 @"sharedPreferences",
					 @"windowWillResize:toSize:",
					 @"toolbarItemClicked:",
					 @"showPreferencesPanelForOwner:"
			 ],
			 @"MessageRouter": @[
					@"putRulesThatWantsToHandleMessage:intoArray:colorRulesOnly:"
			 ]
	};
}

+ (NSDictionary *)hookChangesForMavericks {
	return @{
			 @"MessageContentController": @{
					 @"status": @"removed"
			 },
			 @"MessageViewController": @{
					 @"selectors": @[
							 @"setRepresentedObject:"
					 ]
			 },
			 @"Library": @{
					 @"status": @"renamed",
					 @"name": @"MFLibrary",
					 @"selectors": @{
							 @"replaced": @[
									 @[
										 @"plistDataForMessage:subject:sender:to:dateSent:remoteID:originalMailbox:flags:mergeWithDictionary:",
										 @"plistDataForMessage:subject:sender:to:dateSent:dateReceived:dateLastViewed:remoteID:originalMailboxURLString:gmailLabels:flags:mergeWithDictionary:"
								     ]
							 ]
					 },
			 },
			 @"EAEmailAddressParser": @{
					 @"selectors": @[
							 @"rawAddressFromFullAddress:"
					 ]
			 },
			 @"HeaderViewController": @{
					 @"selectors": @[
							 @"_updateSecurityField",
							 @"awakeFromNib"
					 ]
			 },
			 @"MessageHeaderDisplay": @{
					 @"status": @"removed"
			 },
			 @"MimePart": @{
					 @"status": @"renamed",
					 @"name": @"MCMimePart"
			 },
			 @"MimeBody": @{
					 @"status": @"renamed",
					 @"name": @"MCMimeBody"
			 },
			 @"Message": @{
					 @"status": @"renamed",
					 @"name": @"MCMessage"
			 },
			 @"MessageCriterion": @{
					 @"status": @"renamed",
					 @"name": @"MFMessageCriterion"
			 },
			 @"MailAccount": @{
					 @"status": @"renamed",
					 @"name": @"MFMailAccount"
			 }
	};
}

+ (NSDictionary *)hooks {
	static dispatch_once_t onceToken;
	static NSDictionary *_hooks;
	
	dispatch_once(&onceToken, ^{
		NSMutableDictionary *hooks = [[NSMutableDictionary alloc] init];
		NSDictionary *commonHooks = [self commonHooks];
		
		// Make a mutable version of all the dictionary.
		for(NSString *class in commonHooks)
			hooks[class] = [NSMutableArray arrayWithArray:commonHooks[class]];
		
		if(floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_8)
			[self applyHookChangesForVersion:@"10.9" toHooks:hooks];
		
		_hooks = [NSDictionary dictionaryWithDictionary:hooks];
	});
	
	return _hooks;
}

+ (void)applyHookChangesForVersion:(NSString *)osxVersion toHooks:(NSMutableDictionary *)hooks {
	NSDictionary *hookChanges;
	if([osxVersion isEqualToString:@"10.9"])
		hookChanges = [self hookChangesForMavericks];
	
	for(NSString *class in hookChanges) {
		NSDictionary *hook = hookChanges[class];
		
		// Class was added.
		if(!hooks[class]) {
			hooks[class] = hook[@"selectors"];
			continue;
		}
		// Class was removed.
		if([hook[@"status"] isEqualToString:@"removed"]) {
			[hooks removeObjectForKey:class];
			continue;
		}
		// Selectors were updated
		if(hook[@"selectors"]) {
			for(NSString *action in hook[@"selectors"]) {
				for(id selector in hook[@"selectors"][action]) {
					if([action isEqualToString:@"added"])
						[(NSMutableArray *)hooks[class] addObject:selector];
					else if([action isEqualToString:@"removed"])
						[(NSMutableArray *)hooks[class] removeObject:selector];
					else if([action isEqualToString:@"replaced"]) {
						[(NSMutableArray *)hooks[class] removeObject:selector[0]];
						[(NSMutableArray *)hooks[class] addObject:selector[1]];
					}
				}
			}
		}
		
		// Class was renamed.
		if([hook[@"status"] isEqualToString:@"renamed"]) {
			hooks[hook[@"name"]] = hooks[class];
			[hooks removeObjectForKey:class];
		}
	}
}

+ (void)injectUsingMethodPrefix:(NSString *)prefix {
	/**
     This method replaces all of Mail's methods which are necessary for GPGMail
     to work correctly.
     
     For each class of Mail that must be extended, a class with the same name
     and suffix _GPGMail (<ClassName>_GPGMail) exists which implements the methods
     to be relaced.
     On runtime, these methods are first added to the original Mail class and
     after that, the original Mail methods are swizzled with the ones of the
     <ClassName>_GPGMail class.
     
     swizzleMap contains all classes and methods which need to be swizzled.
     */
	NSDictionary *hooks = [self hooks];
	NSString *extensionClassSuffix = @"GPGMail";
	
	NSError * __autoreleasing error = nil;
    for(NSString *class in hooks) {
        NSArray *selectors = hooks[class];
		
		Class mailClass = NSClassFromString(class);
        if(!mailClass) {
			DebugLog(@"WARNING: Class %@ doesn't exist. This leads to unexpected behaviour!", class);
			continue;
		}
		
		// Check if a class exists with <class>_GPGMail. If that's
		// the case, all the methods of that class, have to be added
		// to the original Mail or Messages class.
		Class extensionClass = NSClassFromString([class stringByAppendingFormat:@"_%@", extensionClassSuffix]);
		BOOL extend = extensionClass != nil ? YES : NO;
		if(extend) {
			if(![mailClass jrlp_addMethodsFromClass:extensionClass error:&error])
				NSLog(@"WARNING: methods of class %@ couldn't be added to %@ - %@", extensionClass,
					  mailClass, error);
		}
		
		// And on to swizzling methods and class methods.
		for(NSString *selectorName in selectors) {
			error = nil;
			NSString *extensionSelectorName = [NSString stringWithFormat:@"%@%@%@", prefix, [[selectorName substringToIndex:1] uppercaseString],
											   [selectorName substringFromIndex:1]];
			SEL selector = NSSelectorFromString(selectorName);
			SEL extensionSelector = NSSelectorFromString(extensionSelectorName);
			// First try to add as instance method.
			[mailClass jrlp_swizzleMethod:selector withMethod:extensionSelector error:&error];
			// If that didn't work, try to add as class method.
			if(error) {
				error = nil;
				[mailClass jrlp_swizzleClassMethod:selector withClassMethod:extensionSelector error:&error];
				if(error)
					NSLog(@"WARNING: %@ doesn't respond to selector %@ - %@", NSStringFromClass(mailClass),
						  NSStringFromSelector(selector), error);
			}
		}
	}
}

@end
