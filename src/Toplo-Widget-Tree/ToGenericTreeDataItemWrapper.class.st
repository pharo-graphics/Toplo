Class {
	#name : #ToGenericTreeDataItemWrapper,
	#superclass : #ToTreeDataItemWrapper,
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToGenericTreeDataItemWrapper >> childrenGetter [

	^ dataSourceWrapper childrenGetter
]

{ #category : #accessing }
ToGenericTreeDataItemWrapper >> computedChildren [

	^ self childrenGetter cull: self
]
