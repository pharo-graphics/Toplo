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
ToTagBarElement >> nodes [

	^ self innerElement nodes
]

{ #category : #accessing }
ToTagBarElement >> nodesCount [

	| count |
	count := 0.
	self nodesDo: [ :node |
		count := count + node nodesCount ].
	^ count
]

{ #category : #'t - list element decorator - children - accessing' }
ToTagBarElement >> nodesDo: aBlock [

	self innerElement nodesDo: aBlock
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
