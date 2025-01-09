Class {
	#name : #ToTabPaneHeaderPositioning,
	#superclass : #Object,
	#category : #'Toplo-Widget-TabPane-Internals'
}

{ #category : #hook }
ToTabPaneHeaderPositioning >> applyOn: aTabPane [
]

{ #category : #accessing }
ToTabPaneHeaderPositioning >> tabGeometry [

	^ self subclassResponsibility 
]
