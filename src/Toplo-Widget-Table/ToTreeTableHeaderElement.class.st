Class {
	#name : #ToTreeTableHeaderElement,
	#superclass : #ToTableHeaderElement,
	#category : #'Toplo-Widget-Table-Header'
}

{ #category : #accessing }
ToTreeTableHeaderElement >> newHeaderColumnsRuler [

	^ ToTreeTableHeaderRulerNodeContainer new
]

{ #category : #accessing }
ToTreeTableHeaderElement >> newHeaderNodeContainer [

	^ ToTreeTableHeaderNodeContainer new
]
