Class {
	#name : #ToListShiftSelectionAction,
	#superclass : #ToListSelectionAction,
	#instVars : [
		'fromIndex',
		'gap'
	],
	#category : #'Toplo-Widget-List-Selection-Action'
}

{ #category : #hook }
ToListShiftSelectionAction >> applyOn: anObject [

	anObject listShiftSelectionAction: self.
	super applyOn: anObject
]

{ #category : #accessing }
ToListShiftSelectionAction >> fromIndex [

	^ fromIndex
]

{ #category : #accessing }
ToListShiftSelectionAction >> fromIndex: anObject [

	fromIndex := anObject
]

{ #category : #accessing }
ToListShiftSelectionAction >> gap [

	^ gap
]

{ #category : #accessing }
ToListShiftSelectionAction >> gap: anInteger [
	" the gap can be positive or negative"

	gap := anInteger
]

{ #category : #initialization }
ToListShiftSelectionAction >> initialize [ 

	super initialize.
	self operation: #shift
]
