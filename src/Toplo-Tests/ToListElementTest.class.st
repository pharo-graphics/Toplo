"
A ToListElementTest is a test class for testing the behavior of ToListElement
"
Class {
	#name : #ToListElementTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Widget-List'
}

{ #category : #tests }
ToListElementTest >> testCanAlternateRowColors [

	| l rows oddRows evenRows oddBackground evenBackground |
	l := ToListElement new alternateRowsColor: true.
	l data addAll: #( 1 2 3 4 5 ).
	l forceLayout.
	rows := l children.

	oddRows := rows asArray withIndexSelect: [ :row :index | index odd ].
	oddBackground := oddRows first background.
	evenRows := rows asArray withIndexSelect: [ :row :index | index even ].
	evenBackground := evenRows first background.
	self
		assert: (oddRows collect: [ :e | e background ] as: Set) size
		equals: 1.
	self
		assert: (evenRows collect: [ :e | e background ] as: Set) size
		equals: 1.

	self deny: oddBackground equals: evenBackground
]
