Class {
	#name : #ToLinearButtonModel,
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
ToLinearButtonModel >> beHorizontal [

	self horizontal: true
]

{ #category : #'api - presentation' }
ToLinearButtonModel >> beIconFirst [

	self labelFirst: false
]

{ #category : #'api - presentation' }
ToLinearButtonModel >> beLabelFirst [

	self labelFirst: true
]

{ #category : #accessing }
ToLinearButtonModel >> beVertical [

	self horizontal: false
]

{ #category : #accessing }
ToLinearButtonModel >> horizontal [

	^ horizontal
]

{ #category : #accessing }
ToLinearButtonModel >> horizontal: aBoolean [

	horizontal := aBoolean
]

{ #category : #accessing }
ToLinearButtonModel >> iconImage [

	^ self iconViewModel image
]

{ #category : #accessing }
ToLinearButtonModel >> iconImage: anElement [

	iconViewModel image: anElement
]

{ #category : #accessing }
ToLinearButtonModel >> iconViewModel [

	^ iconViewModel 
]

{ #category : #initialization }
ToLinearButtonModel >> initialize [ 
	super initialize.
	labelFirst := false.
	horizontal := true.
	labelViewModel := ToLabelModel new.
	iconViewModel := ToImageModel new

]

{ #category : #'api - presentation' }
ToLinearButtonModel >> isIconFirst [
	
	^ self isLabelFirst not
]

{ #category : #'api - presentation' }
ToLinearButtonModel >> isLabelFirst [
	
	^ labelFirst
]

{ #category : #'api - presentation' }
ToLinearButtonModel >> labelFirst [

	^ labelFirst
]

{ #category : #'api - presentation' }
ToLinearButtonModel >> labelFirst: aBoolean [
	
	labelFirst = aBoolean ifTrue: [ ^ self ].
	labelFirst := aBoolean
]

{ #category : #accessing }
ToLinearButtonModel >> labelText [

	^ labelViewModel text
]

{ #category : #accessing }
ToLinearButtonModel >> labelText: aText [

	labelViewModel text: aText
]

{ #category : #accessing }
ToLinearButtonModel >> labelViewModel [

	^ labelViewModel 
]

{ #category : #'api - hooks' }
ToLinearButtonModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	aToButton iconViewModel: iconViewModel labelViewModel: labelViewModel.
	self whenLabelTextReplacedDo: [ aToButton labelTextReplaced ].
	self whenIconImageReplacedDo: [ aToButton iconImageReplaced ].
	self whenPresentationChangedDo: [ aToButton presentationChanged ].
	self whenOrientationChangedDo: [ aToButton orientationChanged ].
	aToButton horizontal: self horizontal.

]

{ #category : #'private - accessing - widget' }
ToLinearButtonModel >> privateWidgetClass [

	^ self subclassResponsibility 
]

{ #category : #'api - change hook' }
ToLinearButtonModel >> whenIconImageReplacedDo: aBlock [

	iconViewModel whenImageReplacedDo: aBlock
]

{ #category : #'api - change hook' }
ToLinearButtonModel >> whenLabelTextReplacedDo: aBlock [

	labelViewModel whenTextReplacedDo: aBlock
]

{ #category : #'api - action' }
ToLinearButtonModel >> whenOrientationChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new action block
	 - old action block"

	self property: #horizontal whenChangedDo: aBlock
]

{ #category : #'api - presentation' }
ToLinearButtonModel >> whenPresentationChangedDo: aBlock [

	"Inform when labelFirst has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new labelFirst
	 - old labelFirst"

	self property: #labelFirst whenChangedDo: aBlock
]
