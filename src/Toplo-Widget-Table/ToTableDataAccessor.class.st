"
The link between the data sources (`ToTableDataSource`) and the `ToTableElement`
"
Class {
	#name : #ToTableDataAccessor,
	#superclass : #ToElement,
	#traits : 'TToDataSourceWrapper + TBlEventTarget + TBlDebug',
	#classTraits : 'TToDataSourceWrapper classTrait + TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'tableElement'
	],
	#category : #'Toplo-Widget-Table-Core'
}

{ #category : #accessing }
ToTableDataAccessor >> tableElement [

	^ tableElement
]

{ #category : #accessing }
ToTableDataAccessor >> tableElement: anObject [

	tableElement := anObject
]

{ #category : #'as yet unclassified' }
ToTableDataAccessor >> tableSource [

	^ tableElement dataSource
]
