Class {
	#name : #ToListBasicSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'positionHook',
		'sizeHook'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #initialization }
ToListBasicSelectionElement >> initialize [

	super initialize.
	positionHook := [ :aPoint :aListElement | aPoint ].
	sizeHook := [ :aPoint :aListElement | aPoint ].

]

{ #category : #private }
ToListBasicSelectionElement >> positionFrom: aPoint in: aListElement [

	^ positionHook value: aPoint value: aListElement
]

{ #category : #accessing }
ToListBasicSelectionElement >> positionHook: aValuable [

	positionHook := aValuable 
]

{ #category : #private }
ToListBasicSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ sizeHook value: aPoint value: aListElement
]

{ #category : #accessing }
ToListBasicSelectionElement >> sizeHook: aValuable [

	sizeHook := aValuable 
]
