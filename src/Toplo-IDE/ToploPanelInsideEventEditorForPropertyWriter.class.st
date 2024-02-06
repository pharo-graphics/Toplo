Class {
	#name : #ToploPanelInsideEventEditorForPropertyWriter,
	#superclass : #ToploPanelInsideEventEditorAbstract,
	#instVars : [
		'animationInput',
		'propertyInput',
		'valueInput',
		'supplementInput'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #accessing }
ToploPanelInsideEventEditorForPropertyWriter >> animationInput [

	^ animationInput
]

{ #category : #layout }
ToploPanelInsideEventEditorForPropertyWriter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: 'Property' expand: false;
		  add: self propertyInput expand: false;
		  add: self supplementInput expand: false;
		  add: 'Value' expand: false;
		  add: self valueInput;
		  add: 'Animation' expand: false;
		  add: self animationInput;
		  yourself
]

{ #category : #initialization }
ToploPanelInsideEventEditorForPropertyWriter >> initializePresenters [

	propertyInput := SpDropListPresenter new.
	supplementInput := SpCheckBoxPresenter new
		                   label: 'supplement';
		                   yourself.
	animationInput := SpCodePresenter new beForScripting; yourself.
	valueInput := SpCodePresenter new beForScripting; yourself.
]

{ #category : #'as yet unclassified' }
ToploPanelInsideEventEditorForPropertyWriter >> makeNewListener [

	| animation supplement value property |
	animation := self animationObject.
	supplement := self supplementObject.
	value := self valueObject.
	property := self propertyObject.
	^ ToPropertyWriter new animation: animation; supplement: supplement; value: value; property: property; yourself
]

{ #category : #accessing }
ToploPanelInsideEventEditorForPropertyWriter >> propertyInput [

	^ propertyInput
]

{ #category : #accessing }
ToploPanelInsideEventEditorForPropertyWriter >> supplementInput [

	^ supplementInput
]

{ #category : #accessing }
ToploPanelInsideEventEditorForPropertyWriter >> theme: aToTheme [

	self propertyInput items: aToTheme styleSheet writablePropertyIndex allProperties
]

{ #category : #initialization }
ToploPanelInsideEventEditorForPropertyWriter >> updatePresenter [

	super updatePresenter.
	self eventListener ifNil: [ ^ self ].
	self eventListener isPropertyWriter ifFalse: [ ^ self ].
	self supplementInput state: self eventListener isSupplement.
	self animationInput
		text: 'self';
		beForObject: self eventListener animation.
	self propertyInput selectItem: self eventListener property.
	
	self eventListener value isBlock ifTrue: [ self valueInput text: self eventListener value printString ] ifFalse: [  self valueInput text: 'self'; beForObject: self eventListener value ]
	
]

{ #category : #accessing }
ToploPanelInsideEventEditorForPropertyWriter >> valueInput [

	^ valueInput
]
