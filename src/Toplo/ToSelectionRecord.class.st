Class {
	#name : #ToSelectionRecord,
	#superclass : #Object,
	#instVars : [
		'selected',
		'focused'
	],
	#category : #'Toplo-Core-States'
}

{ #category : #'instance creation' }
ToSelectionRecord class >> selected: aBoolean focused: otherBoolean [

	^ self new
		  selected: aBoolean;
		  focused: otherBoolean;
		  yourself
]

{ #category : #accessing }
ToSelectionRecord >> focused [

	^ focused
]

{ #category : #accessing }
ToSelectionRecord >> focused: aBoolean [

	focused := aBoolean
]

{ #category : #testing }
ToSelectionRecord >> isSelected: aBoolean focused: otherBoolean [

	^ selected = aBoolean and: [ focused = otherBoolean ]
]

{ #category : #accessing }
ToSelectionRecord >> selected [

	^ selected
]

{ #category : #accessing }
ToSelectionRecord >> selected: aBoolean [

	selected := aBoolean
]
