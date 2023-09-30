Class {
	#name : #ToComboBoxHead,
	#superclass : #ToButton,
	#instVars : [
		'comboBox'
	],
	#category : #'Toplo-Widget-ComboBox'
}

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

	^ ToLabel new hMatchParent; yourself
]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> hidePlaceholder [
	^ self subclassResponsibility
]

{ #category : #initialization }
ToComboBoxHead >> initialize [

	super initialize.
	self replaceFirstWith: ((ToImage inner: (Smalltalk ui icons iconNamed: #bottom))
			 hFitContent;
			 yourself).
	self first withStamp: #'button-icon'.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	self withStamp: #button.
	self withStamp: #'label-first'.
	self withStamp: #'small-sizing'.
	self justified: true



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
