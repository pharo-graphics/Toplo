Class {
	#name : #ToTagBarElement,
	#superclass : #ToGenericBarElement,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'instance creation' }
ToTagBarElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #initialization }
ToTagBarElement >> defaultNodeManagerClass [

	^ ToTagNodeManager
]

{ #category : #initialization }
ToTagBarElement >> initialize [

	super initialize.
	self sample: 'X'
]

{ #category : #'t - list element decorator - children - accessing' }
ToTagBarElement >> nodeContainers [

	^ self innerElement nodeContainers
]

{ #category : #'t - list element decorator - children - accessing' }
ToTagBarElement >> nodeContainersDo: aBlock [

	self innerElement nodeContainersDo: aBlock
]

{ #category : #accessing }
ToTagBarElement >> nodesCount [

	| count |
	count := 0.
	self nodeContainersDo: [ :container |
		count := count + container nodesCount ].
	^ count
]

{ #category : #'t - bar element' }
ToTagBarElement >> sample: aData [

	super sample: (ToSingleTag new
			 data: aData;
			 yourself)
]

{ #category : #accessing }
ToTagBarElement >> tagBuilder: aValuable [

	self nodeManager tagBuilder: aValuable.
	self notifyDataSourceChanged 
]
