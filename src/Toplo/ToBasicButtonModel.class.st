Class {
	#name : #ToBasicButtonModel,
	#superclass : #ToViewModel,
	#instVars : [
		'#labelViewModel',
		'#iconViewModel',
		'#action => ObservableSlot',
		'#labelFirst => ObservableSlot',
		'#horizontal => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - action' }
ToBasicButtonModel >> action [
	"Answer the block performed when the button is clicked."

	^ action
]

{ #category : #'api - action' }
ToBasicButtonModel >> action: aBlock [
	"Set the block performed when the button is clicked. 
	 `aBlock` receives zero arguments."

	action := aBlock
]

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

	anEvent consumed: true.
	self announce: ToButtonLaunchAction new.
	self announce: ToButtonActionPerformed new
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
	action := [  ].
	labelFirst := false.
	horizontal := true.
	labelViewModel := ToLabelModel new.
	iconViewModel := ToImageModel new.
	self whenLaunchActionDo: [ self launchAction ].

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

{ #category : #'api - action' }
ToBasicButtonModel >> launchAction [

	action value
]

{ #category : #'api - hooks' }
ToBasicButtonModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	aToButton iconViewModel: iconViewModel labelViewModel: labelViewModel.
	self whenLabelTextReplacedDo: [ aToButton labelTextReplaced ].
	self whenIconImageReplacedDo: [ aToButton iconImageReplaced ].
	self whenPresentationChangedDo: [ aToButton presentationChanged ].
	self whenOrientationChangedDo: [ aToButton orientationChanged ].
	aToButton when: BlClickEvent do: [ :anEvent | aToButton clickEvent: anEvent ]
]

{ #category : #'private - accessing - widget' }
ToBasicButtonModel >> privateNewWidget [

	^ self subclassResponsibility 
]

{ #category : #'api - action' }
ToBasicButtonModel >> whenActionChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #action whenChangedDo: aBlock
]

{ #category : #'api - action' }
ToBasicButtonModel >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonActionPerformed do: aBlock
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
ToBasicButtonModel >> whenLaunchActionDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonLaunchAction do: aBlock
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
