Class {
	#name : #ToTagBarElement,
	#superclass : #ToBarElement,
	#category : #'Toplo-Widget-Tag-Bar'
}

{ #category : #'instance creation' }
ToTagBarElement class >> onSelectElement: aSelectElement [

	^ self basicNew
		  selectElement: aSelectElement;
		  initialize
]

{ #category : #initialization }
ToTagBarElement >> defaultEventHandler [ 

	^ ToTagBarEventHandler new
]

{ #category : #initialization }
ToTagBarElement >> defaultNodeManager [

	^ ToTagNodeManager new
]

{ #category : #layout }
ToTagBarElement >> extentChanged [
]

{ #category : #initialization }
ToTagBarElement >> initialize [

	super initialize.
	
	" mandatory resizer setting. 
	Normally, should not be changed"
	self vFitContent.
	self hMatchParent 
]

{ #category : #'t - children - accessing' }
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

{ #category : #accessing }
ToTagBarElement >> nodesDo: aBlock [

	self innerElement nodesDo: aBlock
]

{ #category : #accessing }
ToTagBarElement >> nodesSelect: aBlock [

	^ self innerElement nodesSelect: aBlock
]

{ #category : #accessing }
ToTagBarElement >> sample: aData [

	super sample: (ToSingleTagModel new
			 data: aData;
			 yourself)
]

{ #category : #accessing }
ToTagBarElement >> withCloseButton [

	^ false
]
