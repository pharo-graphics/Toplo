Class {
	#name : #ToButtonViewModel,
	#superclass : #ToViewModel,
	#instVars : [
		'#labelViewModel',
		'#iconViewModel',
		'#action => ObservableSlot',
		'#labelFirst'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - action' }
ToButtonViewModel >> action [
	"Answer the block performed when the button is clicked."

	^ action
]

{ #category : #'api - action' }
ToButtonViewModel >> action: aBlock [
	"Set the block performed when the button is clicked. 
	 `aBlock` receives zero arguments."

	action := aBlock
]

{ #category : #'api - action' }
ToButtonViewModel >> clickEvent: anEvent [

	self action value.
	self announce: ToButtonActionPerformed new
]

{ #category : #initialization }
ToButtonViewModel >> defaultDresser [

	^ ToButtonBasicDresser new
	
]

{ #category : #initialization }
ToButtonViewModel >> defaultIconImage [

	^ (BlElement new
		  size: 16 @ 16;
		  border: (BlBorder paint: Color gray width: 2);
		  background: (Color gray alpha: 0.2);
		  geometry: BlCircleGeometry new ).
]

{ #category : #initialization }
ToButtonViewModel >> defaultLabelText [

	^ 'Button'
]

{ #category : #accessing }
ToButtonViewModel >> iconImage [

	^ iconViewModel image
]

{ #category : #accessing }
ToButtonViewModel >> iconImage: anElement [

	iconViewModel image: anElement
]

{ #category : #accessing }
ToButtonViewModel >> iconViewModel [

	^ iconViewModel 
]

{ #category : #initialization }
ToButtonViewModel >> initialize [ 
	super initialize.
	action := [  ].
	labelViewModel := ToLabelViewModel new.
	iconViewModel := ToImageViewModel new.
]

{ #category : #accessing }
ToButtonViewModel >> labelText [

	^ labelViewModel text
]

{ #category : #accessing }
ToButtonViewModel >> labelText: aText [

	labelViewModel text: aText
]

{ #category : #accessing }
ToButtonViewModel >> labelViewModel [

	^ labelViewModel 
]

{ #category : #'api - change hook' }
ToButtonViewModel >> onIconImageReplacedDo: aBlock [

	iconViewModel onImageReplacedDo: aBlock
]

{ #category : #'api - hooks' }
ToButtonViewModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	self labelText: self defaultLabelText.
	self iconImage: self defaultIconImage.
	aToButton labelViewModel: labelViewModel.
	aToButton iconViewModel: iconViewModel.
	self onLabelTextReplacedDo: [ aToButton labelTextReplaced ].
	self onIconImageReplacedDo: [ aToButton iconImageReplaced ].
	aToButton when: BlClickEvent do: [ :anEvent | self clickEvent: anEvent ]

]

{ #category : #'api - change hook' }
ToButtonViewModel >> onLabelTextReplacedDo: aBlock [

	labelViewModel onTextReplacedDo: aBlock
]

{ #category : #'private - accessing - widget' }
ToButtonViewModel >> privateNewWidget [

	^ ToButton new 
]

{ #category : #'api - action' }
ToButtonViewModel >> whenActionChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #action whenChangedDo: aBlock
]

{ #category : #'api - action' }
ToButtonViewModel >> whenActionPerformedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."

	self whenAnnouncement: ToButtonActionPerformed do: aBlock
]
