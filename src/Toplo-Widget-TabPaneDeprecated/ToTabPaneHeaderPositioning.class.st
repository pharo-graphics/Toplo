Class {
	#name : #ToTabPaneHeaderPositioning,
	#superclass : #Object,
	#category : #'Toplo-Widget-TabPaneDeprecated-Internals'
}

{ #category : #testing }
ToTabPaneHeaderPositioning class >> isDeprecated [ 

	^ true
]

{ #category : #hook }
ToTabPaneHeaderPositioning >> applyOn: aTabPane [
]

{ #category : #accessing }
ToTabPaneHeaderPositioning >> tabGeometry [

	^ self subclassResponsibility 
]
