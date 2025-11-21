Trait {
	#name : #TToGenericTreeNodeManager,
	#instVars : [
		'childrenGetter'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - generic tree node manager' }
TToGenericTreeNodeManager >> childrenFromDataItem: aDataItem [

	^ (childrenGetter value: aDataItem) asArray
]

{ #category : #'t - generic tree node manager' }
TToGenericTreeNodeManager >> childrenGetter: aValuable [

	childrenGetter := aValuable
]

{ #category : #'t - generic tree node manager' }
TToGenericTreeNodeManager >> defaultChildrenGetter [

	^ [ :dataItem | #(  ) ]
]

{ #category : #'t - generic tree node manager' }
TToGenericTreeNodeManager >> initializeAsGenericTreeNodeManager [ 

	childrenGetter := self defaultChildrenGetter
]
