Class {
	#name : #MenuBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'toploExampleMenu',
		'worldMenuExample'
	],
	#category : #'Toplo-MenuRegistration-Tests'
}

{ #category : #'tests - before resolution' }
MenuBuilderTest >> testBeforeResolveSimpleItemNoParentAvailable [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	self 
		assert: builder collectedItems size 
		equals: 1.
	self 
		assert: builder collectedItems first parent 
		equals: #Tools
]

{ #category : #'tests - Pragma' }
MenuBuilderTest >> testBuilderBeforePragmasCollectedItems [

	| builder |
	builder := ToMenuBuilder pragmaKeyword: #toploWorldMenu1.
	builder collectRegistrations.
	self 
		assert: builder collectedItems size 
		equals: 3.
		
	self assert: (builder indexOfChildNamed: #Im) equals: 1.
	self assert: (builder indexOfChildNamed: #aSuperMenu) equals: 2.
	self assert: (builder indexOfChildNamed: #anUglyMenu) equals: 3.
	
]

{ #category : #'tests - Pragma' }
MenuBuilderTest >> testBuilderPragmas [

	| prgas |
	prgas := self toploExampleMenu pragmas.
	self 
		assert: prgas size 
		equals: 1.
	self 
		assert: prgas first selector
		equals: #toploWorldMenu1.
		
]

{ #category : #'tests - Pragma' }
MenuBuilderTest >> testBuilderResolvePragmasCollectedItems [

	self 
		assert: self toploExampleMenu collectedItems size 
		equals: 1.
]

{ #category : #'tests - conflicts' }
MenuBuilderTest >> testDefinitionOfTwoSimilarParentIsAConflict [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #Tools) label: 'The root tools'.

	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	(builder item: #Tools) label: 'The root tools'.
	
	self assert: builder hasConflict
]

{ #category : #'tests - diff' }
MenuBuilderTest >> testDiffBrowseMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Browsing.

	listWorldItemName := (concernItem itemNamed: #Browsing) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #Browsing) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #Browsing) itemList size
		equals:
		((aBuilder itemsNamed: #Browse) childrenFromGroup: #Browsing) size.
	self
		assert:
			(((aBuilder itemsNamed: #Browse) childrenFromGroup: #Browsing)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderTest >> testDiffDebugMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Debug.
	listWorldItemName := (concernItem itemNamed: #Profiling) itemList
		                     collect: [ :child | child name ].
	self
		assert: (concernItem itemNamed: #Profiling) itemList size
		equals: 3.
	self
		assert: (concernItem itemNamed: #Profiling) itemList size
		equals:
		((aBuilder itemsNamed: #Debug) childrenFromGroup: #Profiling) size.
	self
		assert:
			(((aBuilder itemsNamed: #Debug) childrenFromGroup: #Profiling)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderTest >> testDiffPharoMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Pharo.
	listWorldItemName := (concernItem itemNamed: #Saving) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #Saving) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #Saving) itemList size
		equals:
		((aBuilder itemsNamed: #Pharo) childrenFromGroup: #Saving) size.
	self
		assert:
			(((aBuilder itemsNamed: #Pharo) childrenFromGroup: #Saving)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderTest >> testDiffSourcesMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #Sources.
	listWorldItemName := (concernItem itemNamed: #Refactoring) itemList
		                     collect: [ :child | child name ].
	self
		assert: (concernItem itemNamed: #Refactoring) itemList size
		equals: 2.
	self
		assert: (concernItem itemNamed: #Refactoring) itemList size
		equals:
		((aBuilder itemsNamed: #Sources) childrenFromGroup: #Refactoring) size.
	self
		assert:
			(((aBuilder itemsNamed: #Sources) childrenFromGroup: #Refactoring)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - diff' }
MenuBuilderTest >> testDiffSystemMenu [

	| aBuilder oldBuilder concernItem listWorldItemName |
	self skip.
	aBuilder := self worldMenuExampleExampleMenu.
	oldBuilder := PragmaMenuBuilder pragmaKeyword: 'worldMenu' model: nil.
	oldBuilder buildTree.
	concernItem := oldBuilder itemNamed: #System.

	listWorldItemName := (concernItem itemNamed: #World) itemList
		                     collect: [ :child | child name ].
	self assert: (concernItem itemNamed: #World) itemList size equals: 3.
	self
		assert: (concernItem itemNamed: #World) itemList size
		equals:
		((aBuilder itemsNamed: #System) childrenFromGroup: #World) size.
	self
		assert:
			(((aBuilder itemsNamed: #System) childrenFromGroup: #World)
				 collect: [ :item | item name ])
		equals: listWorldItemName
]

{ #category : #'tests - conflicts' }
MenuBuilderTest >> testDuplicatedIdenticalItem [

	| builder |
	builder := ToMenuBuilder new.

	builder item: #MyOwnCoolMenu.
	builder item: #MyOwnCoolMenu.

	self assert: builder collectedItems size equals: 1.
	self assert: builder hasConflict
]

{ #category : #'tests - conflicts' }
MenuBuilderTest >> testDuplicatedIdenticalItemShortcut [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #PrettyMenu) shortcut: 'u'.
	(builder item: #UglyMenu) shortcut: 'u'.
	builder resolve.
	self assert: builder collectedItems size equals: 2.
	self assert: builder hasConflict.
]

{ #category : #'tests - conflicts' }
MenuBuilderTest >> testDuplicatedIdenticalItemWithChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	builder resolve.
	self 
		assert: builder collectedItems size 
		equals: 1.
	self
		assert: builder collectedItems first childrenItems size
		equals: 1.
	self
		assert: builder hasConflict
]

{ #category : #'tests - conflicts' }
MenuBuilderTest >> testDuplicatedIdenticalItemWithDifferentChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobLeMenu ].
	builder resolve.
	self 
		assert: builder collectedItems size 
		equals: 1.
	self
		assert: builder collectedItems first childrenItems size
		equals: 2.
	self 
		assert: builder hasConflict
]

{ #category : #tests }
MenuBuilderTest >> testOrderedTree [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyMenu)
		order: 3;
		with: [
			(builder item: #MyMenuChild1)
				parent: #MyMenu;
				order: 9999.
			(builder item: #MyMenuChild2)
				parent: #MyMenu;
				order: 1 ].
	(builder item: #MySecondMenu)
		order: 1;
		with: [
			(builder item: #MySecondMenuChild1)
				parent: #MySecondMenu;
				order: 9999.
			(builder item: #MySecondMenuChild2)
				parent: #MySecondMenu;
				order: 1 ].
	builder resolve.

	self 
		assert: builder collectedItems first name 
		equals: #MySecondMenu.
	self 
		assert: builder collectedItems last name 
		equals: #MyMenu.
	self
		assert: (builder itemsNamed: #MySecondMenu) childrenItems first name
		equals: #MySecondMenuChild2
]

{ #category : #'tests - todo' }
MenuBuilderTest >> testResolveAnUnknownParent [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	builder resolve.
	self
		assert: (builder itemsNamed: #MyOwnCoolTool) parent
		equals: #Tools.
	self assert:
		(builder itemsNamed: #MyOwnCoolTool) parentMenuItem isNil.

	self assert: builder hasConflict.
	self assert: builder conflicts first class equals: ParentNotFound
]

{ #category : #'tests - duplicated items' }
MenuBuilderTest >> testResolveThreeDepth [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #Root) label: 'The root tools'.

	(builder item: #Sub)
		parent: #Root;
		label: 'A subitem'.

	(builder item: #SubSub)
		parent: #Sub;
		label: 'A subsubitem'.

	builder resolve.

	self assert: builder collectedItems size equals: 1
]

{ #category : #'tests - duplicated items' }
MenuBuilderTest >> testResolveThreeDepthBroken [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #Root) label: 'The root tools'.

	(builder item: #Sub)
		parent: #Root;
		label: 'A subitem'.

	(builder item: #SubSub)
		parent: #SubBroken;
		label: 'A subsubitem'.

	builder resolve.

	self assert: builder collectedItems size equals: 2
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testResolveWithDeclaresOneItemWithAChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyMenu)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(builder item: #MyMenuChild)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].

	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
		(builder itemsNamed: #MyMenu) childrenItems first label
		equals: 'My own cool tool also here'.

	self
		assert:
		(builder itemsNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testResolveWithDeclaresOneItemWithAParentAndAChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyMenu)
		parent: #Tools;
		groupName: #BeautifulMenu;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyMenuChild)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].

	builder resolve.
	self assert: builder groups size equals: 1.
	self
		assert: (builder groupsNamed: #BeautifulMenu) childrenItems size
		equals: 2.
	self
		assert:
			((builder groupsNamed: #BeautifulMenu) childrenItems collect: [
				 :item | item name ])
		equals: { #MyMenu. #MyMenuChild } asOrderedCollection.
	self
		assert: (builder itemsNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testResolveWithItemWithExplicitParentUnknowDeclared [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #MyMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyBrokenItem)
				parent: #MyBrokenMenu;
				label: 'My own cool tool also here'.
			(builder item: #MyItem)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].
	builder resolve.

	"
		When we use a with, it force to correct the explicit unknown parent/wrong parent placement
	"
	self assert: builder collectedItems size equals: 1.

	self
		assert: (builder itemsNamed: #MyMenu) childrenItems first name
		equals: #MyBrokenItem.

	self
		assert: (builder itemsNamed: #MyMenu) childrenItems first parent
		equals: #MyMenu.
]

{ #category : #'tests - before resolution' }
MenuBuilderTest >> testSimpleItemBeforeParentDefinition [

	| builder |
	builder := ToMenuBuilder new.
	
	"we create a first item whose parent will be created after"
	(builder item: #MyOwnCoolTool)
		parent: #Tools;
		label: 'My own cool tool'.

	"we create its parent after"
	(builder item: #Tools) 
		label: 'The root tools'.

	self 
		assert: builder collectedItems size 
		equals: 2.
	self 
		assert: builder collectedItems first parent 
		equals: #Tools
]

{ #category : #tests }
MenuBuilderTest >> testSimpleItemInAnUndeclaredGroupCreatesGroup [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #Tools)
		label: 'The root tools';
		groupName: #OurGroup.

	builder resolve.
	self 
		assert: builder groups size 
		equals: 1.
	self assert: (builder groups includes: #OurGroup).
	self 
		assert: (builder groupsNamed: #OurGroup) childrenItems first name 
		equals: #Tools
]

{ #category : #tests }
MenuBuilderTest >> testSimpleItemInGroupAlreadyDeclared [

	| builder |
	builder := ToMenuBuilder new.
	builder group: #OurGroup.

	(builder item: #Tools)
		label: 'The root tools';
		groupName: #OurGroup.
	builder resolve.
	
	self 
		assert: builder collectedItems size 
		equals: 2.
	self
		assert: (builder groupsNamed: #OurGroup) childrenItems first name
		equals: #Tools
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testSimpleItemWithItemNoParentDeclared [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool) label: 'My own cool tool also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.
	self
		assert: (builder itemsNamed: #MyOwnCoolMenu) parent
		equals: #Tools.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				parent
		equals: #MyOwnCoolMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testSimpleItemWithItemWhoHaveAChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu)
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				with: [
					(builder item: #MyOwnCoolTool2) label:
							'My own cool tool 2 also here'.]].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
		(builder itemsNamed: #MyOwnCoolMenu) childrenItems first label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				childrenItems size
		equals: 1.
	self
		assert: ((builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				 findChildrenItems: #MyOwnCoolTool2) label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testSimpleItemWithItemWithExplicitParentDeclared [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				parent: #MyOwnCoolMenu;
				label: 'My own cool tool also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				parent
		equals: #MyOwnCoolMenu
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testSimpleItemWithMultiplesItemsWithExpliciteDeclaredParent [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				parent: #MyOwnCoolMenu;
				label: 'My own cool tool also here'.
			(builder item: #MyOwnCoolTool2)
				parent: #MyOwnCoolMenu;
				label: 'My own cool tool 2 also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems second
				label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - resolve phase' }
MenuBuilderTest >> testSimpleItemWithMultiplesItemsWithNoParentDeclared [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu)
		parent: #Tools;
		label: 'The coolest tool here';
		with: [
			(builder item: #MyOwnCoolTool)
				label: 'My own cool tool also here'.
			(builder item: #MyOwnCoolTool2)
				label: 'My own cool tool 2 also here' ].
	builder resolve.

	self assert: builder collectedItems size equals: 1.

	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems first
				label
		equals: 'My own cool tool also here'.
	self
		assert:
			(builder itemsNamed: #MyOwnCoolMenu) childrenItems second
				label
		equals: 'My own cool tool 2 also here'.
]

{ #category : #'tests - duplicated items' }
MenuBuilderTest >> testThreeDepth [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #Root) label: 'The root tools'.

	(builder item: #Sub)
		parent: #Root;
		label: 'A subitem'.

	(builder item: #SubSub)
		parent: #Sub;
		label: 'A subsubitem'.


	self assert: builder collectedItems size equals: 3
]

{ #category : #'tests - todo' }
MenuBuilderTest >> testTwoGroupsWithSameName [

	| builder |
	builder := ToMenuBuilder new.
	
	(builder group: #Tools) label: 'The root tools'.
	(builder group: #Tools) label: 'The root tools'.

	self 
		assert: builder groups size 
		equals: 1.
	self assert: (builder groups includes: #Tools).
]

{ #category : #tests }
MenuBuilderTest >> testWithDeclaresOneItemWithAChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyMenu)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(builder item: #MyMenuChild)
				parent: #MyMenu;
				label: 'My own cool tool also here' ].

	"At this stage (before resolving) the child is created by the builder but not in the parent list and 
	as such removed from the collected items."

	self assert: builder collectedItems size equals: 2.

	self
		assert: (builder itemsNamed: #MyMenuChild) parent
		equals: #MyMenu.

	self
		assert: (builder itemsNamed: #MyMenuChild) parent
		equals: #MyMenu.

	self
		assert: (builder itemsNamed: #MyMenuChild) label
		equals: 'My own cool tool also here'
]

{ #category : #examples }
MenuBuilderTest >> toploExampleMenu [

	^ toploExampleMenu ifNil: [ 
			toploExampleMenu := self toploExampleMenuBuilder: ToMenuBuilder ]
]

{ #category : #examples }
MenuBuilderTest >> toploExampleMenuBuilder: aClass [

	^ (aClass pragmaKeyword: #toploWorldMenu1)
		  collectRegistrations;
		  resolve;
		  yourself
]

{ #category : #'world menu' }
MenuBuilderTest >> worldMenuExampleExampleMenu [

	^ worldMenuExample ifNil: [
		  worldMenuExample := self worldMenuExampleMenuBuilder: ToMenuBuilder ]
]

{ #category : #'world menu' }
MenuBuilderTest >> worldMenuExampleMenuBuilder: aClass [

	^ (aClass pragmaKeyword: #worldMenu)
		  collectRegistrations;
		  resolve;
		  yourself
]
