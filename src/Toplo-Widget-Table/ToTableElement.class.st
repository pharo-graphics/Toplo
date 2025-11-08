"
I am the main entry point to reprensent a Table based on the [ant design](https://ant.design/components/table)
"
Class {
	#name : #ToTableElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#columns => ObservableSlot',
		'#showHeader'
	],
	#category : #'Toplo-Widget-Table'
}

{ #category : #accessing }
ToTableElement >> columns [

	^ columns
]

{ #category : #accessing }
ToTableElement >> columns: anObject [

	columns := anObject
]

{ #category : #initialization }
ToTableElement >> defaultNodeManagerClass [
	^ ToTableNodeManager
]

{ #category : #initialization }
ToTableElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	showHeader := true.
	self
		property: #columns
		whenChangedDo: [ self nodeManager columns: self columns ]
]
