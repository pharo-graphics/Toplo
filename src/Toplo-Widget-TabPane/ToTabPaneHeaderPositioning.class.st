Class {
	#name : 'ToTabPaneHeaderPositioning',
	#superclass : 'Object',
	#category : 'Toplo-Widget-TabPane',
	#package : 'Toplo-Widget-TabPane'
}

{ #category : 'hook' }
ToTabPaneHeaderPositioning >> applyOn: aTabPane [
]

{ #category : 'accessing' }
ToTabPaneHeaderPositioning >> tabGeometry [

	^ self subclassResponsibility 
]
