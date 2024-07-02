Class {
	#name : #ToListBasicAdditionalSelectionElement,
	#superclass : #ToListSelectionElement,
	#instVars : [
		'positionHook',
		'sizeHook'
	],
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #initialization }
ToListBasicAdditionalSelectionElement >> initialize [ 

	super initialize.
	positionHook := [ :aPoint :aListElement | aPoint ].
	sizeHook := [ :aPoint :aListElement | aPoint ]
]

{ #category : #private }
ToListBasicAdditionalSelectionElement >> positionFrom: aPoint in: aListElement [

	^ positionHook value: aPoint value: aListElement
]

{ #category : #accessing }
ToListBasicAdditionalSelectionElement >> positionHook: aValuable [

	positionHook := aValuable 
]

{ #category : #private }
ToListBasicAdditionalSelectionElement >> sizeFrom: aPoint in: aListElement [

	^ sizeHook value: aPoint value: aListElement
]

{ #category : #accessing }
ToListBasicAdditionalSelectionElement >> sizeHook: aValuable [

	sizeHook := aValuable 
]
