Class {
	#name : #ToListSelectionLabelInDecorationAdaptionEvent,
	#superclass : #ToListSelectionDecorationEvent,
	#instVars : [
		'label'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListSelectionLabelInDecorationAdaptionEvent >> label [

	^ label
]

{ #category : #accessing }
ToListSelectionLabelInDecorationAdaptionEvent >> label: aLabel [

	label := aLabel
]
