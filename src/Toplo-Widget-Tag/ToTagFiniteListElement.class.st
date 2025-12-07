Class {
	#name : #ToTagFiniteListElement,
	#superclass : #AnObsoleteToGenericFiniteListElement,
	#category : #'Toplo-Widget-Tag-Tag'
}

{ #category : #'instance creation' }
ToTagFiniteListElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #initialization }
ToTagFiniteListElement >> defaultNodeManagerClass [

	^ ToTagNodeManager
]

{ #category : #initialization }
ToTagFiniteListElement >> initialize [

	super initialize.
	self sample: 'X'
]

{ #category : #'t - list element decorator - children - accessing' }
ToTagFiniteListElement >> nodeContainers [

	^ self innerElement nodeContainers
]

{ #category : #'t - list element decorator - children - accessing' }
ToTagFiniteListElement >> nodeContainersDo: aBlock [

	self innerElement nodeContainersDo: aBlock
]

{ #category : #accessing }
ToTagFiniteListElement >> nodesCount [

	| count |
	count := 0.
	self nodeContainersDo: [ :container |
		count := count + container node nodesCount ].
	^ count
]

{ #category : #'t - bar element' }
ToTagFiniteListElement >> sample: aData [

	super sample: (ToSingleTag new
			 data: aData;
			 yourself)
]

{ #category : #accessing }
ToTagFiniteListElement >> tagBuilder: aValuable [

	self nodeManager tagBuilder: aValuable.
	self notifyDataSourceChanged 
]
