"
I am a Strategy that will use the function on the visible items of the tree.

Description
-----------------------

I will search in the vsible items of the tree.
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
	ds searchStrategy: #default. ""This will say to the ToFTTreeDataSource to use me, but since this is the default, this is optional.""
	ToFTTableMorph new
		extent: 200 @ 400;
		dataSource: ds;
		explicitFunction;
		openInWindow
 
"
Class {
	#name : #ToFTVisibleItemsStrategy,
	#superclass : #ToFTTreeFunctionStrategy,
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #action }
ToFTVisibleItemsStrategy >> filter [
	| items |
	items := OrderedCollection new.
	dataSource rootsItems do: [ :item | (self matchingFilter: item) ifNotNil: [ :itemNew | items add: itemNew ] ] displayingProgress: [ :each | 'Looking inside ' , each printString ].
	dataSource table selectIndex: 1.
	^ dataSource class
		root:
			(ToFTRootItem new
				children: items asArray;
				yourself)
		children: dataSource childrenBlock
]

{ #category : #action }
ToFTVisibleItemsStrategy >> matchingFilter: anItem [
	anItem isExpanded
		ifTrue:
			[ ((anItem children collect: [ :each | self matchingFilter: each ]) reject: #isNil)
				ifNotEmpty: [ :coll |
					^ (self newStaticItemFrom: anItem)
						children: coll asArray;
						expandWithoutChange;
						yourself ] ].
	^ (pattern matchesIn: (self dataSource toString: anItem))
		ifNotEmpty: [ anItem isExpanded
				ifTrue: [ self newStaticItemFrom: anItem ]
				ifFalse: [ anItem ] ]
		ifEmpty: [ nil ]
]

{ #category : #action }
ToFTVisibleItemsStrategy >> newStaticItemFrom: anItem [
	^ ToFTStaticBasicItem new
		data: anItem data;
		depth: anItem depth;
		children: #();
		yourself
]

{ #category : #action }
ToFTVisibleItemsStrategy >> realSearch [
	| result cpt |
	result := OrderedCollection new.
	cpt := 0.
	dataSource rootsItems
		do:
			[ :item |
			1 to: item numberOfVisibleChildren + 1 do: [ :index |
				| elem |
				elem := item selfOrChildAt: index.
				(self isMatching: elem)
					ifTrue: [ result add: index + cpt ] ].
			cpt := cpt + (item numberOfVisibleChildren + 1) ].
	^ result asArray
]
