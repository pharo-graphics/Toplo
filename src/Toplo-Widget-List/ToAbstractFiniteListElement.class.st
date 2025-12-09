Class {
	#name : #ToAbstractFiniteListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TToFiniteListElement + TToConfigurableFiniteListElement',
	#classTraits : 'TToFiniteListElement classTrait + TToConfigurableFiniteListElement classTrait',
	#category : #'Toplo-Widget-List-Core-FiniteListElement'
}

{ #category : #initialization }
ToAbstractFiniteListElement >> initialize [

	super initialize.
	self initializeAsFiniteListElement.

]
