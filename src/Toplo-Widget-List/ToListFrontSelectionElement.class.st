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

	beneath := aBoolean
]

{ #category : #initialization }
ToListFrontSelectionElement >> initialize [ 

	super initialize.
	beneath := true
]

{ #category : #private }
ToListFrontSelectionElement >> positionFrom: aPoint [

	^ super positionFrom: (self selectionMode positionFrom: aPoint forSelectionElement: self)
]

{ #category : #accessing }
ToListFrontSelectionElement >> selectionMode [

	^ self subclassResponsibility 
]

{ #category : #private }
ToListFrontSelectionElement >> sizeFrom: aPoint [

	^ super sizeFrom: (self selectionMode sizeFrom: aPoint forSelectionElement: self)
]
