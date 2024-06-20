Class {
	#name : #ToListFrontSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'beneath'
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
