Class {
	#name : #ToTabsElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabsElementSkin >> checkNodeMenuIn: aTabsElement [

	| menuImage nodeMenu |
	(aTabsElement isWrapping or: [ aTabsElement isScrolling ]) ifTrue: [ ^ self ].
	menuImage := ToMaterialDesignIconProvider innerImageNamed:
		             'outlined_menu'.
	nodeMenu := ToTabNodeMenu new iconImage: menuImage.
	nodeMenu tabsElement: aTabsElement.
	nodeMenu icon size: 20 asPoint.

	nodeMenu builder: (self defaultNodeMenuBuilderIn: aTabsElement).
	aTabsElement itemBar userData at: #nodeMenu put: nodeMenu.
	aTabsElement endElement: nodeMenu
]

{ #category : #initialization }
ToTabsElementSkin >> defaultNodeMenuBuilderIn: aTabsElement [

	^ [ :menu :request |
	  | group middlePos |
	  group := ToCheckableGroup new.
	  middlePos := aTabsElement visibleNodes
		               ifEmpty: [ 0 ]
		               ifNotEmpty: [ :vn | vn first holder position - 1 ].
	  aTabsElement invisibleNodes do: [ :node |
		  node isEnabled ifTrue: [
			  group register: (ToRadioMenuItem new
					   labelText: node item label text asString;
					   checked: node item isChecked;
					   closeOnPicking: false;
					   whenClickedDo: [ :event |
						   aTabsElement itemBar selecter
							   scrollTowardStartToDataSourcePosition: node holder position.
						   aTabsElement itemBar requestFocus.
						   node item checked: true ];
					   yourself) ] ].
	  menu addAllItems: group registeredCheckables.
	  menu addSeparatorBeforeIndex: (middlePos max: 1) ]
]

{ #category : #'event handling' }
ToTabsElementSkin >> installSkinEvent: anEvent [

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		| selTrack |
		e clipChildren: true.
		e middleContainer clipChildren: true.
		self checkNodeMenuIn: e.
		e isWrapping ifFalse: [
			selTrack := ToElement new
				            background: (e valueOfTokenNamed: #'border-paint');
				            id: #'selection-track'.
			selTrack constraintsDo: [ :c | c ignoreByLayout ].
			e itemBar userData at: #'selection-track' put: selTrack.
			e isHorizontal
				ifTrue: [
					selTrack constraintsDo: [ :c |
						c ignored horizontal alignLeft.
						c ignored vertical alignBottom ].
					selTrack height: 2.
					selTrack hMatchParent ]
				ifFalse: [
					selTrack constraintsDo: [ :c |
						c ignored horizontal alignRight.
						c ignored vertical alignTop ].
					selTrack width: 2.
					selTrack vMatchParent ].
			e middleContainer addChild: selTrack ].
		e background: Color transparent.
		e border: BlBorder empty]
]

{ #category : #'event handling' }
ToTabsElementSkin >> uninstallSkinEvent: anEvent [

	super uninstallSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e itemBar nodeMenu ifNotNil: [ :nm | nm removeFromParent ].
		e itemBar userData removeKey: #nodeMenu ifAbsent: [  ].
		e itemBar userData removeKey: #'selection-track' ifAbsent: [  ].
		(e childWithId: #'selection-track' ifNone: [  ]) ifNotNil: [
			:selTrack | selTrack removeFromParent ] ]
]
