Class {
	#name : #ToComboBoxHead,
	#superclass : #ToElement,
	#instVars : [
		'comboBox',
		'innerElement',
		'button'
	],
	#category : 'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxHead >> button [

	^ button
]

{ #category : #accessing }
ToComboBoxHead >> comboBox [

	^ comboBox
]

{ #category : #accessing }
ToComboBoxHead >> comboBox: aComboBox [

	comboBox := aComboBox
]

{ #category : #initialization }
ToComboBoxHead >> defaultPlaceholder [

	^ (ToLabel text: '') hMatchParent; yourself
]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> hidePlaceholder [
	^ self subclassResponsibility
]

{ #category : #initialization }
ToComboBoxHead >> initialize [

	| image |
	super initialize.
	self layout: BlLinearLayout horizontal.
	self padding: (BlInsets
			 top: 1
			 left: 7
			 bottom: 1
			 right: 2).
	self border: (BlBorder paint: Color lightGray).
	self
		hMatchParent;
		vFitContent.
		
	innerElement := ToElement new.
	innerElement layout: BlLinearLayout horizontal.
	innerElement constraintsDo: [ :c | c linear vertical alignCenter ].
	innerElement hMatchParent.
	innerElement height: 25.
	
	image := ToImage inner: (Smalltalk ui icons iconNamed: #bottom).
	image constraintsDo: [ :c | c linear vertical alignCenter ].
	button := ToButton new.
	button icon: image.
	button addStamp: #'small-sizing'.

	self addChild: innerElement.
	self addChild: button after: innerElement.

]

{ #category : #accessing }
ToComboBoxHead >> noDataSelected [

	self showPlaceholder 
]

{ #category : #accessing }
ToComboBoxHead >> placeholder [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToComboBoxHead >> placeholder: anElement [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToComboBoxHead >> selectData: aData in: aComboBox [

	self subclassResponsibility 
]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> showPlaceholder [

	^ self subclassResponsibility
]
