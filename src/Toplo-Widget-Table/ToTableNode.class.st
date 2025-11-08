Class {
	#name : #ToTableNode,
	#superclass : #ToListNode,
	#instVars : [
		'columns'
	],
	#category : #'Toplo-Widget-Table'
}

{ #category : #'instance creation' }
ToTableNode class >> withColumns: aListOfToColumn [

	^ self new
		  columns: aListOfToColumn;
		  yourself
]

{ #category : #accessing }
ToTableNode >> columns [

	^ columns
]

{ #category : #accessing }
ToTableNode >> columns: anObject [

	columns := anObject.
	self resetConfiguration
]

{ #category : #initialization }
ToTableNode >> initialize [

	super initialize.
	self resetConfiguration
]

{ #category : #initialization }
ToTableNode >> resetConfiguration [

	self columns ifNotNil: [ :cols |
			cols do: [ :column |
					self addChild: (ToElement new
							 id: column key;
							 matchParent;
							 yourself) ] ]
]
