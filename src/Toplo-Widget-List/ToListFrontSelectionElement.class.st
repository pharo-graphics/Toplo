Class {
	#name : #ToListFrontSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'selectionOption'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListFrontSelectionElement class >> selectionOption: aSelectionOption focused: aBoolean [

	^ self new
		  selectionOption: aSelectionOption;
		  focused: aBoolean;
		  yourself
]

{ #category : #accessing }
ToListFrontSelectionElement >> isBeneath [

	^ selectionOption isBeneath
]

{ #category : #accessing }
ToListFrontSelectionElement >> selectionMode [

	^ selectionOption selectionMode
]

{ #category : #accessing }
ToListFrontSelectionElement >> selectionOption [

	^ selectionOption
]

{ #category : #accessing }
ToListFrontSelectionElement >> selectionOption: aSelectionOption [

	selectionOption := aSelectionOption
]
