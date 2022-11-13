Class {
	#name : #ToBasicButtonModel,
	#superclass : #ToViewModel,
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
	aToButton
		when: BlClickEvent
		do: [ :anEvent | aToButton clickEvent: anEvent ].
	aToButton
		when: BlDoubleClickEvent
		do: [ :anEvent | aToButton clickEvent: anEvent ].
	"Because of the button has sub-elements, a Mouse up can a different target than the related mouse down but it can come from the button or from one of its children (if mouse has slided from the label to the icon as an example)"
	
	"mouse up must be consumed here so that BlClickCandidateEvent is created with the right BlMouseUpEvent"
	aToButton
		when: BlMouseUpEvent
		do: [ :anEvent | anEvent consumed: true ].
		
	"then try to manage hidden click "
	aToButton when: BlClickCandidateEvent do: [ :anEvent | 
		| mup |
		mup := anEvent mouseUpEvent.
		(mup currentTarget == aToButton or: [ 
			 mup currentTarget hasParent: aToButton ]) ifTrue: [ aToButton dispatchEvent: mup asClickEvent ] ]
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
