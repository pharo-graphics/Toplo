"
I represent the list part of the table
"
Class {
	#name : #ToTableListElement,
	#superclass : #ToAbstractListElement,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#columns => ObservableSlot'
	],
	#category : #'Toplo-Widget-Table-List'
}

{ #category : #accessing }
ToTableListElement >> columns [

	^ columns
]

{ #category : #accessing }
ToTableListElement >> columns: anObject [

	columns := anObject
]

{ #category : #initialization }
ToTableListElement >> defaultNodeManagerClass [

	^ ToTableNodeManager
]

{ #category : #initialization }
ToTableListElement >> initialize [

	super initialize.
	self class initializeSlots: self.
	self property: #columns whenChangedDo: [
			self nodeManager columns: self columns.
			self notifyDataSourceChanged ]
]

{ #category : #skin }
ToTableListElement >> newRawSkin [ 

	^ ToTableListElementSkin new
]
