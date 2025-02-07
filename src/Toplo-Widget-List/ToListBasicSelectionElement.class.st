Class {
	#name : #ToListBasicSelectionElement,
	#superclass : #ToListSelectionElement,
	#category : #'Toplo-Widget-List-Selection-Element'
}

{ #category : #deprecation }
ToListBasicSelectionElement class >> isDeprecated [
	" use my superclass instead"

	^ true
]

{ #category : #initialization }
ToListBasicSelectionElement >> initialize [

	super initialize.
	self outskirts: BlOutskirts inside
]
