Class {
	#name : #ToBasicButtonViewModel,
	#superclass : #ToViewModel,
	#instVars : [
		'#labelViewModel',
		'#iconViewModel',
		'#action => ObservableSlot',
		'#labelFirst => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - action' }
ToBasicButtonViewModel >> action [
	"Answer the block performed when the button is clicked."

	^ action
]

{ #category : #'api - action' }
ToBasicButtonViewModel >> action: aBlock [
	"Set the block performed when the button is clicked. 
	 `aBlock` receives zero arguments."

	action := aBlock
]

{ #category : #'api - action' }
ToBasicButtonViewModel >> clickEvent: anEvent [

	self action value.
	self announce: ToButtonActionPerformed new
]

{ #category : #initialization }
ToBasicButtonViewModel >> defaultDresser [

	^ ToBasicButtonDresser new
	
]

{ #category : #initialization }
ToBasicButtonViewModel >> defaultIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: (Color gray alpha: 0.2);
		  geometry: BlCircleGeometry new ).
]

{ #category : #initialization }
ToBasicButtonViewModel >> defaultLabelText [

	^ 'Button'
]

{ #category : #accessing }
ToBasicButtonViewModel >> iconImage [

	^ self iconViewModel image
]

{ #category : #accessing }
ToBasicButtonViewModel >> iconViewModel [

	^ iconViewModel 
]

{ #category : #initialization }
ToBasicButtonViewModel >> initialize [ 
	super initialize.
	action := [  ].
	labelFirst := false. 
	labelViewModel := ToLabelViewModel new.
	iconViewModel := ToImageViewModel new.
]

{ #category : #'api - presentation' }
ToBasicButtonViewModel >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'api - presentation' }
ToBasicButtonViewModel >> isLabelFirst [
	
	^ labelFirst
]

{ #category : #'api - presentation' }
ToBasicButtonViewModel >> labelFirst [

	^ labelFirst
]

{ #category : #'api - presentation' }
ToBasicButtonViewModel >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean
]

{ #category : #accessing }
ToBasicButtonViewModel >> labelText [

	^ labelViewModel text
]

{ #category : #accessing }
ToBasicButtonViewModel >> labelText: aText [

	labelViewModel text: aText
]

{ #category : #accessing }
ToBasicButtonViewModel >> labelViewModel [

	^ labelViewModel 
]

{ #category : #'api - change hook' }
ToBasicButtonViewModel >> onIconImageReplacedDo: aBlock [

	iconViewModel onImageReplacedDo: aBlock
]

{ #category : #'api - hooks' }
ToBasicButtonViewModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	aToButton labelViewModel: labelViewModel.
	aToButton iconViewModel: iconViewModel.
	self onLabelTextReplacedDo: [ aToButton labelTextReplaced ].
	self onIconImageReplacedDo: [ aToButton iconImageReplaced ].
	self onPresentationChangedDo: [ aToButton presentationChanged ].
	aToButton when: BlClickEvent do: [ :anEvent | aToButton clickEvent: anEvent ]

]

{ #category : #'api - change hook' }
ToBasicButtonViewModel >> onLabelTextReplacedDo: aBlock [

	labelViewModel onTextReplacedDo: aBlock
]

{ #category : #'api - presentation' }
ToBasicButtonViewModel >> onPresentationChangedDo: aBlock [

	"Inform when labelFirst has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #labelFirst whenChangedDo: aBlock
]

{ #category : #'private - accessing - widget' }
ToBasicButtonViewModel >> privateNewWidget [

	^ ToButton new 
]

{ #category : #'api - action' }
ToBasicButtonViewModel >> whenActionChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #action whenChangedDo: aBlock
]

{ #category : #'api - action' }
ToBasicButtonViewModel >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonActionPerformed do: aBlock
]
