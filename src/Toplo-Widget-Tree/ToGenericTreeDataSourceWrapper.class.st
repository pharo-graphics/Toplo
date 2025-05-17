Class {
	#name : #ToGenericTreeDataSourceWrapper,
	#superclass : #ToTreeDataSourceWrapper,
	#instVars : [
		'childrenGetter'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToGenericTreeDataSourceWrapper >> childrenGetter [

	^ childrenGetter
]

{ #category : #accessing }
ToGenericTreeDataSourceWrapper >> childrenGetter: aValuable [

	childrenGetter := aValuable
]
