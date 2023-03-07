"
I am a Strategy that will use the function on the roots item only.

Description
-----------------------

I will search in the roots item of the tree.
As said in my superclass I am use by a ToFTTreeDataSource to help with a ToFTFunction.

Public API and Key Messages
-----------------------

- #realSearch 	is the method that will launch the search.

Example
-----------------------

	| ds |
	ds := ToFTTreeDataSource
		roots:
			((ProtoObject allSubclasses sort: [ :a :b | a asString < b asString ])
				reject: [ :e | e asString endsWith: 'class' ])
		children: [ :item | item subclasses sort: [ :a :b | a asString < b asString ] ].
	ds searchStrategy: #rootsOnly. ""This will say to the ToFTTreeDataSource to use me.""
	ToFTTableMorph new
		extent: 200 @ 400;
		dataSource: ds;
		explicitFunction;
		openInWindow
 
"
Class {
	#name : #ToFTRootItemsStrategy,
	#superclass : #ToFTTreeFunctionStrategy,
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #action }
ToFTRootItemsStrategy >> filter [
	^ dataSource class
		root:
			(ToFTRootItem new
				children: (dataSource rootsItems select: [ :each | (pattern matchesIn: (self dataSource toString: each)) notEmpty ]);
				yourself)
		children: dataSource childrenBlock
]

{ #category : #action }
ToFTRootItemsStrategy >> realSearch [
	| result index |
	result := OrderedCollection new.
	index := 1.
	dataSource rootsItems
		do: [ :item |
			(self isMatching: item)
				ifTrue: [ result add: index ].
			index := index + (item numberOfVisibleChildren + 1) ].
	^ result asArray
]
