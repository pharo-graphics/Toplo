Class {
	#name : #ToListFrontSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'beneath'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #accessing }
ToListFrontSelectionElement class >> beneath: aBoolean [

	^ self new beneath: aBoolean
]

{ #category : #accessing }
ToListFrontSelectionElement >> beneath [

	^ beneath
]

{ #category : #accessing }
ToListFrontSelectionElement >> beneath: aBoolean [

	beneath := aBoolean.
	beneath
		ifTrue: [ self elevation: (BlRelativeElevation elevation: 0) ]
		ifFalse: [
			self preventMeAndChildrenMouseEvents.
			self elevation: (BlRelativeElevation elevation: 50) ]
]

{ #category : #initialization }
ToListFrontSelectionElement >> initialize [ 

	super initialize.
	beneath := true
]
