Class {
	#name : #ToListSelectionCheckbox,
	#superclass : #ToIconicButton,
	#instVars : [
		'checked'
	],
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #'t - checkable - accessing' }
ToListSelectionCheckbox >> allowIndeterminate: aBoolean [
]

{ #category : #accessing }
ToListSelectionCheckbox >> checked [

	^ checked
]

{ #category : #accessing }
ToListSelectionCheckbox >> checked: aBooleanOrNil [

	checked = aBooleanOrNil ifTrue: [ ^ self ].
	checked := aBooleanOrNil.
	self requestNewSkin
]

{ #category : #initialization }
ToListSelectionCheckbox >> initialize [ 

	super initialize.
	checked := false.
	self id: #'list-selection-checkbox'
]

{ #category : #testing }
ToListSelectionCheckbox >> isChecked [

	^ self checked = true
]

{ #category : #testing }
ToListSelectionCheckbox >> isIndeterminate [

	^ self checked isNil
]

{ #category : #skin }
ToListSelectionCheckbox >> newRawSkin [ 

	^ ToListSelectionCheckboxSkin new
]
