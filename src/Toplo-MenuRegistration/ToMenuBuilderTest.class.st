Class {
	#name : #ToMenuBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'xmenu',
		'tmenu'
	],
	#category : #'Toplo-MenuRegistration'
}

{ #category : #differential }
ToMenuBuilderTest >> menuBuilder: aClass [

	^ (aClass
		   pragmaKeyword: #worldMenu
		   model: self)
		  menuSpec;
		  yourself
]

{ #category : #differential }
ToMenuBuilderTest >> setUp [

	xmenu := self menuBuilder: XPragmaMenuBuilder.
	tmenu := self menuBuilder: ToPragmaCleanMenuBuilder
]

{ #category : #'simple tests' }
ToMenuBuilderTest >> testBuilderCreationAPI [

	| b |
	b := ToPragmaMenuBuilder
				pragmaKeywords: { #toploWorldMenuExample } model: nil.
	self assert: b menuSpec items size equals: 5
]

{ #category : #'simple tests' }
ToMenuBuilderTest >> testBuilderHasItems [

	| b |
	b := ToPragmaMenuBuilder
		     pragmaKeyword: #toploWorldMenuExample
		     model: nil.
	self assert: b menuSpec items size equals: 5
]

{ #category : #'simple tests' }
ToMenuBuilderTest >> testBuilderPragmas [

	| b |
	b := ToPragmaCleanMenuBuilder
		     pragmaKeywords: { #toploWorldMenuExample }
		     model: nil.
	self assert: b pragmas size equals: 5
]

{ #category : #'simple tests' }
ToMenuBuilderTest >> testBuilderPragmasWhenPragmaDoesntExist [

	| b |
	b := ToPragmaCleanMenuBuilder pragmaKeyword: #sdfghjgfdsdfghj model: nil.
	self assert: b pragmas size equals: 0
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildOrder [

	| xTools |
	xTools := xmenu itemNamed: #Tools.
	self assert: xTools order equals: 70.
	self
		assert: xTools order
		equals: (tmenu itemNamed: #Tools) order
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootIsRoot [

	| xPharo |
	xPharo := xmenu itemNamed: #Pharo.
	self assert: xPharo owner isGroup.
	self
		assert: xPharo owner isGroup
		equals: (tmenu itemNamed: #Pharo) owner isGroup
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootItemListSize [

	| xPharo |
	xPharo := xmenu itemNamed: #Pharo.
	self assert: xPharo owner itemList size equals: 12.
	self
		assert: xPharo owner itemList size
		equals: (tmenu itemNamed: #Pharo) owner itemList size.
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootPragmaKeyword [

	| xPharo |
	xPharo := xmenu itemNamed: #Pharo.
	self assert: xPharo owner pragmaKeywords size equals: 1.
	self
		assert: xPharo owner pragmaKeywords size
		equals: (tmenu itemNamed: #Pharo) owner pragmaKeywords size.
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffChildRootPragmaKeywordSize [

	| xPharo |
	xPharo := xmenu itemNamed: #Pharo.
	self assert: xPharo owner pragmaKeywords size equals: 1.
	self
		assert: xPharo owner pragmaKeywords size
		equals: (tmenu itemNamed: #Pharo) owner pragmaKeywords size.
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemChildNamed [

	| xSettings |
	xSettings := (xmenu itemNamed: #Pharo) itemNamed: #Settings.
	self assert: xSettings name equals: #Settings.
	self
		assert: xSettings name
		equals: ((tmenu itemNamed: #Pharo) itemNamed: #Settings) name.
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemChildSize [

	| xPharo |
	xPharo := xmenu itemNamed: #Pharo.
	self assert: xPharo itemList size equals: 3.
	self
		assert: xPharo itemList size
		equals: (tmenu itemNamed: #Pharo) itemList size
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemListSize [

	self assert: xmenu itemList size equals: 12.
	self assert: xmenu itemList size equals: tmenu itemList size
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffItemNamed [

	| xSettings |
	xSettings := xmenu itemNamed: #Settings.
	self assert: xSettings name equals: #Settings.
	self
		assert: xSettings name
		equals: (tmenu itemNamed: #Settings) name
]

{ #category : #differential }
ToMenuBuilderTest >> testDiffRootIsGroup [

	self assert: xmenu isGroup.
	self assert: xmenu isGroup equals: tmenu isGroup
]

{ #category : #tests }
ToMenuBuilderTest >> testNewBuilderBuildMenuSpec [

	| aBuilder |
	aBuilder := ToPragmaMenuBuilder
		     pragmaKeyword: #toploWorldMenuExample
		     model: nil.
	aBuilder buildMenuSpec: ToPluggableMenuItemSpec new.
	self assert: aBuilder spec class equals: ToPluggableMenuItemSpec
]

{ #category : #tests }
ToMenuBuilderTest >> testNewBuilderSpec [

	| builder menu item |
	builder := ToPragmaMenuBuilder new.
	menu := ToMenuRegistration new.
	menu owner: builder.
	item := menu item: #MyOwnCoolMenu.

	self deny: item == menu.
	self assert: item parentName equals: nil.
	self assert: item label equals: #MyOwnCoolMenu
]

{ #category : #tests }
ToMenuBuilderTest >> testNewBuilderSpecWithChild [

	| aBuilder |
	aBuilder := ToMenuRegistration new owner: ToPragmaMenuBuilder new.
	(aBuilder item: #MyOwnCoolMenu)
		parent: #Tools;
		"place me as a child of the #Tools node (declared by #toolsOn:)"
		label: 'The coolest tool here';
		with: [
			(aBuilder item: #MyOwnCoolTool)
				label: 'My own cool tool also here';
				target: Smalltalk tools workspace;
				selector: #openContents:;
				arguments:
					#( 'yep, my own cool tool can be also opened from a world sub-menu ! :)' ) ].
	self assert: aBuilder spec class equals: ToPluggableMenuItemSpec
]

{ #category : #tests }
ToMenuBuilderTest >> testNewConnectedMenuItem [

	| builder menu item |
	builder := ToPragmaMenuBuilder new.
	menu := ToMenuRegistration new.
	menu owner: builder.
	item := builder item: #MyOwnCoolMenu.
	"Why this is not a builder item: #my...."
	item parent: #Tools.
	self assert: item parentName equals: #Tools.
	self assert: item owner equals: builder
]

{ #category : #tests }
ToMenuBuilderTest >> testNewUnconnectedMenuItem [

	| builder menu item |
	builder := ToPragmaMenuBuilder new.
	menu := ToMenuRegistration new.
	menu owner: builder.
	item := menu item: #MyOwnCoolMenu.

	self deny: item == menu.
	self assert: item parentName equals: nil.
	self assert: item label equals: #MyOwnCoolMenu.
]
