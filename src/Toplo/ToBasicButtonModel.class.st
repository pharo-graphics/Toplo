Class {
	#name : #ToBasicButtonModel,
	#superclass : #ToViewModel,
	#instVars : [
		'#labelViewModel',
		'#iconViewModel',
		'#labelFirst => ObservableSlot',
		'#horizontal => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToBasicButtonModel >> beHorizontal [

	self horizontal: true
]

{ #category : #'api - presentation' }
ToBasicButtonModel >> beIconFirst [

	self labelFirst: false
]

{ #category : #'api - presentation' }
ToBasicButtonModel >> beLabelFirst [

	self labelFirst: true
]

{ #category : #accessing }
ToBasicButtonModel >> beVertical [

	self horizontal: false
]

{ #category : #'api - action' }
ToBasicButtonModel >> clickEvent: anEvent [


]

{ #category : #initialization }
ToBasicButtonModel >> defaultDresser [

	^ ToBasicButtonDresser new
	
]

{ #category : #accessing }
ToBasicButtonModel >> horizontal [

	^ horizontal
]

{ #category : #accessing }
ToBasicButtonModel >> horizontal: aBoolean [

	horizontal := aBoolean
]

{ #category : #accessing }
ToBasicButtonModel >> iconImage [

	^ self iconViewModel image
]

{ #category : #accessing }
ToBasicButtonModel >> iconViewModel [

	^ iconViewModel 
]

{ #category : #initialization }
ToBasicButtonModel >> initialize [ 
	super initialize.
	labelFirst := false.
	horizontal := true.
	labelViewModel := ToLabelModel new.
	iconViewModel := ToImageModel new

]

{ #category : #'api - presentation' }
ToBasicButtonModel >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'api - presentation' }
ToBasicButtonModel >> isLabelFirst [
	
	^ labelFirst
]

{ #category : #'api - presentation' }
ToBasicButtonModel >> labelFirst [

	^ labelFirst
]

{ #category : #'api - presentation' }
ToBasicButtonModel >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean
]

{ #category : #accessing }
ToBasicButtonModel >> labelText [

	^ labelViewModel text
]

{ #category : #accessing }
ToBasicButtonModel >> labelText: aText [

	labelViewModel text: aText
]

{ #category : #accessing }
ToBasicButtonModel >> labelViewModel [

	^ labelViewModel 
]

{ #category : #'api - hooks' }
ToBasicButtonModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	aToButton iconViewModel: iconViewModel labelViewModel: labelViewModel.
	self whenLabelTextReplacedDo: [ aToButton labelTextReplaced ].
	self whenIconImageReplacedDo: [ aToButton iconImageReplaced ].
	self whenPresentationChangedDo: [ aToButton presentationChanged ].
	self whenOrientationChangedDo: [ aToButton orientationChanged ].
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
ToBasicButtonModel >> privateNewWidget [

	^ self subclassResponsibility 
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

{ #category : #'api - change hook' }
ToBasicButtonModel >> whenIconImageReplacedDo: aBlock [

	iconViewModel whenImageReplacedDo: aBlock
]

{ #category : #'api - change hook' }
ToBasicButtonModel >> whenLabelTextReplacedDo: aBlock [

	labelViewModel whenTextReplacedDo: aBlock
]

{ #category : #'api - action' }
ToBasicButtonModel >> whenOrientationChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #horizontal whenChangedDo: aBlock
]

{ #category : #'api - presentation' }
ToBasicButtonModel >> whenPresentationChangedDo: aBlock [

	"Inform when labelFirst has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new labelFirst
	 - old labelFirst"

	self property: #labelFirst whenChangedDo: aBlock
]
