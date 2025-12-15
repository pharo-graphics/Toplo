Class {
	#name : #ToTableHeaderRowNode,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #'t - table node' }
ToTableHeaderRowNode >> cellContainerAt: anIndex [ 

	^ self childAt: anIndex
]

{ #category : #'t - table node' }
ToTableHeaderRowNode >> cellContainers [ 

	^ self children asArray
]

{ #category : #initialization }
ToTableHeaderRowNode >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #initialization }
ToTableHeaderRowNode >> initialize [

	super initialize.
	self hMatchParent.
	self vFitContent
]
