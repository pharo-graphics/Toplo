Class {
	#name : #ToButtonModel,
	#superclass : #ToBasicButtonModel,
	#instVars : [
		'#labelViewModel',
		'#iconViewModel',
		'#labelFirst => ObservableSlot',
		'#horizontal => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToButtonModel >> beHorizontal [

	self horizontal: true
]

{ #category : #'api - presentation' }
ToButtonModel >> beIconFirst [

	self labelFirst: false
]

{ #category : #'api - presentation' }
ToButtonModel >> beLabelFirst [

	self labelFirst: true
]

{ #category : #accessing }
ToButtonModel >> beVertical [

	self horizontal: false
]

{ #category : #accessing }
ToButtonModel >> horizontal [

	^ horizontal
]

{ #category : #accessing }
ToButtonModel >> horizontal: aBoolean [

	horizontal := aBoolean
]

{ #category : #accessing }
ToButtonModel >> iconImage [

	^ self iconViewModel image
]

{ #category : #accessing }
ToButtonModel >> iconImage: anElement [

	iconViewModel image: anElement
]

{ #category : #accessing }
ToButtonModel >> iconViewModel [

	^ iconViewModel 
]

{ #category : #initialization }
ToButtonModel >> initialize [ 
	super initialize.
	labelFirst := false.
	horizontal := true.
	labelViewModel := ToLabelModel new.
	iconViewModel := ToImageModel new

]

{ #category : #'api - presentation' }
ToButtonModel >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'api - presentation' }
ToButtonModel >> isLabelFirst [
	
	^ labelFirst
]

{ #category : #'api - presentation' }
ToButtonModel >> labelFirst [

	^ labelFirst
]

{ #category : #'api - presentation' }
ToButtonModel >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean
]

{ #category : #accessing }
ToButtonModel >> labelText [

	^ labelViewModel text
]

{ #category : #accessing }
ToButtonModel >> labelText: aText [

	labelViewModel text: aText
]

{ #category : #accessing }
ToButtonModel >> labelViewModel [

	^ labelViewModel 
]

{ #category : #'api - hooks' }
ToButtonModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	aToButton iconViewModel: iconViewModel labelViewModel: labelViewModel.
	self whenLabelTextReplacedDo: [ aToButton labelTextReplaced ].
	self whenIconImageReplacedDo: [ aToButton iconImageReplaced ].
	self whenPresentationChangedDo: [ aToButton presentationChanged ].
	self whenOrientationChangedDo: [ aToButton orientationChanged ].
	aToButton horizontal: self horizontal.

]

{ #category : #'private - accessing - widget' }
ToButtonModel >> privateWidgetClass [

	^ ToButton
]

{ #category : #'api - change hook' }
ToButtonModel >> whenIconImageReplacedDo: aBlock [

	iconViewModel whenImageReplacedDo: aBlock
]

{ #category : #'api - change hook' }
ToButtonModel >> whenLabelTextReplacedDo: aBlock [

	labelViewModel whenTextReplacedDo: aBlock
]

{ #category : #'api - action' }
ToButtonModel >> whenOrientationChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #horizontal whenChangedDo: aBlock
]

{ #category : #'api - presentation' }
ToButtonModel >> whenPresentationChangedDo: aBlock [

	"Inform when labelFirst has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new labelFirst
	 - old labelFirst"

	self property: #labelFirst whenChangedDo: aBlock
]
