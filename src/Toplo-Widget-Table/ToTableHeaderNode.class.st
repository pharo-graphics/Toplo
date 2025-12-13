Class {
	#name : #ToTableHeaderNode,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'t - table node' }
ToTableHeaderNode >> cellContainerAt: anIndex [ 

	^ self childAt: anIndex
]

{ #category : #'t - table node' }
ToTableHeaderNode >> cellContainers [ 

	^ self children asArray
]

{ #category : #initialization }
ToTableHeaderNode >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToTableHeaderNode >> initialize [

	super initialize.
	self hMatchParent.
	self vFitContent
]
