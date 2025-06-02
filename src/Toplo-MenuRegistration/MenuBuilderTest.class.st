Class {
	#name : #MenuBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'toploExampleMenu'
	],
	#category : #'Toplo-MenuRegistration-NewCreate'
}

{ #category : #'general-testing' }
MenuBuilderTest >> testDefinitionOfTwoSimilarParentIsAConflict [

	| builder |
	builder := ToMenuBuilder new.
	(builder item: #Tools) label: 'The root tools'.

	(builder item: #MyOwnCoolTool)
		parentName: #Tools;
		label: 'My own cool tool'.

	(builder item: #Tools) label: 'The root tools'.
	self deny: builder hasNoConflict
]

{ #category : #'general-testing' }
MenuBuilderTest >> testDuplicatedIdenticalItem [
	
	| builder |
	builder := ToMenuBuilder new.
	
	builder item: #MyOwnCoolMenu.
	builder item: #MyOwnCoolMenu.

	self 
		assert: builder collectedItems size 
		equals: 1.
		
]

{ #category : #'general-testing' }
MenuBuilderTest >> testDuplicatedIdenticalItemWithChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	builder resolve.
	self assert: builder collectedItems size equals: 1.
	self assert: builder collectedItems first childrenItems size equals: 1
]

{ #category : #'general-testing' }
MenuBuilderTest >> testDuplicatedIdenticalItemWithDifferentChild [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobbyLeMenu ].
	(builder item: #MyOwnCoolMenu) with: [ builder item: #BobLeMenu ].
	self assert: builder collectedItems size equals: 1.
	self
		assert: builder collectedItems first childrenItems size
		equals: 2
]

{ #category : #'general-testing' }
MenuBuilderTest >> testSimpleItemBeforeParentDefinition [
	
	| builder |
	builder := ToMenuBuilder new.
	(builder item: #MyOwnCoolTool)
		parentName: #Tools;
		label: 'My own cool tool'.
	
	(builder item: #Tools)
		label: 'The root tools'.
	
	self 
		assert: builder collectedItems size 
		equals: 2. 
	self 
		assert: builder collectedItems first parentName 
		equals: #Tools. 
]

{ #category : #'general-testing' }
MenuBuilderTest >> testSimpleItemInAnUndeclaredGroup [

	| builder |
	builder := ToMenuBuilder new.

	(builder item: #Tools)
		label: 'The root tools';
		groupName: #OurGroup.

	builder resolve.
	self assert: builder groups size equals: 1.
	self assert: (builder groups includesKey: #OurGroup).
	self assert: (builder groups at: #OurGroup) first name equals: #Tools
]

{ #category : #'general-testing' }
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
		equals: 1. 
	self 
		assert: (builder groups at: #OurGroup) first name 
		equals: #Tools. 
]

{ #category : #'general-testing' }
MenuBuilderTest >> testSimpleItemNoParentAvailable [
	
	| builder |
	builder := ToMenuBuilder new.
	(builder item: #MyOwnCoolTool)
		parentName: #Tools;
		label: 'My own cool tool'.
		
	self 
		assert: builder collectedItems size 
		equals: 1. 
	self 
		assert: builder collectedItems first parentName 
		equals: #Tools. 
]

{ #category : #'general-testing' }
MenuBuilderTest >> testSimpleItemWithItem [
	
	| builder |
	builder := ToMenuBuilder new.
	
	(builder item: #MyOwnCoolMenu)
		parentName: #Tools; "place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [ (builder item: #MyOwnCoolTool) 
						parentName: #MyOwnCoolMenu;
						label: 'My own cool tool also here' ].
	builder resolve.	
	self 
		assert: builder collectedItems size 
		equals: 1.

	self 
		assert: builder collectedItems first childrenItems first label equals: 'My own cool tool also here'.
	
	self 
		assert: builder collectedItems first childrenItems first parentName equals: #MyOwnCoolMenu.
		
]

{ #category : #'general-testing' }
MenuBuilderTest >> testSimpleItemWithItemNoParentDeclared [
	
	| builder |
	builder := ToMenuBuilder new.
	
	(builder item: #MyOwnCoolMenu)
		parentName: #Tools; "place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [ (builder item: #MyOwnCoolTool) 
						label: 'My own cool tool also here' ].
	builder resolve.
	self 
		assert: builder collectedItems size 
		equals: 1.
	self 
		assert: builder collectedItems first parentName 
		equals: nil. 
	self 
		assert: builder collectedItems first childrenItems first label equals: 'My own cool tool also here'.
	
	self 
		assert: builder collectedItems first childrenItems first parentName equals: #MyOwnCoolMenu.
		
]

{ #category : #'general-testing' }
MenuBuilderTest >> testSimpleItemWithItemWithExplicitParentDeclared [
	
	| builder |
	builder := ToMenuBuilder new.
	
	(builder item: #MyOwnCoolMenu)
		parentName: #Tools;
		label: 'The coolest tool here';
		with: [ (builder item: #MyOwnCoolTool) 
						parentName: #MyOwnCoolMenu;
						label: 'My own cool tool also here' ].
	builder resolve.
	self 
		assert: builder collectedItems size 
		equals: 1.

	self 
		assert: builder collectedItems first childrenItems first label equals: 'My own cool tool also here'.
	
	self 
		assert: builder collectedItems first childrenItems first parentName equals: #MyOwnCoolMenu.
		
]

{ #category : #'general-testing' }
MenuBuilderTest >> testSimpleItemWithItemWithExplicitUnknownParentDeclared [

	| builder child |
	builder := ToMenuBuilder new.

	child := (builder item: #MyOwnCoolTool) parentName: #Potato.

	(builder item: #MyOwnCoolMenu)
		parentName: #Tools;
		with: [ child ].

	builder resolve.

	"Hypothese : Default case will put the child at the root or in the corrected parent"
	self assert: builder collectedItems size equals: 2.

	self deny:
		(builder collectedItems first childrenItems includes: child).
	self deny: builder hasNoConflict.
	self assert: builder collectedItems second parentName equals: nil
]

{ #category : #'general-testing' }
MenuBuilderTest >> toploExampleMenu [

	^ toploExampleMenu ifNil: [ 
			toploExampleMenu := self toploExampleMenuBuilder: ToMenuBuilder ]
]

{ #category : #'general-testing' }
MenuBuilderTest >> toploExampleMenuBuilder: aClass [

	^ (aClass pragmaKeyword: #toploWorldMenuExample model: self)
		  collectRegistrations;
		  menuSpec;
		  yourself
]
