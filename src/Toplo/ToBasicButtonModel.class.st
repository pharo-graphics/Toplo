Class {
	#name : #ToBasicButtonModel,
	#superclass : #ToViewModel,
	#instVars : [
		'basicHandler'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - action' }
ToBasicButtonModel >> clickEvent: anEvent [


]

{ #category : #initialization }
ToBasicButtonModel >> defaultDresser [

	^ ToBasicButtonDresser new
	
]

{ #category : #'api - hooks' }
ToBasicButtonModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	basicHandler := ToBasicButtonEventHandler new button: aToButton.
	aToButton addEventHandler: basicHandler
]

{ #category : #'api - hooks' }
ToBasicButtonModel >> onUninstalledOnlyMeIn: aToButton [

	super onUninstalledOnlyMeIn: aToButton.
	aToButton removeEventHandler: basicHandler
]

{ #category : #'private - accessing - widget' }
ToBasicButtonModel >> privateWidgetClass [

	^ ToBasicButton
]

{ #category : #'api - action' }
ToBasicButtonModel >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonActionPerformed do: aBlock
]

{ #category : #'api - action' }
ToBasicButtonModel >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."
	
	self whenAnnouncement: ToButtonLaunchClickAction do: aBlock
]
