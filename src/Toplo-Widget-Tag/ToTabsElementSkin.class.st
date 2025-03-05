Class {
	#name : #ToTabsElementSkin,
	#superclass : #ToItemBarElementSkin,
	#category : #'Toplo-Widget-Tag-Tab'
}

{ #category : #'event handling' }
ToTabsElementSkin >> checkNodeMenuIn: aTabsElement [

	| menuImage nodeMenu |
	aTabsElement isWrapping ifTrue: [ ^ self ].
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
	  | middlePos |
	  middlePos := aTabsElement visibleNodes
		               ifEmpty: [ 0 ]
		               ifNotEmpty: [ :vn | vn first holder position - 1 ].
	  aTabsElement invisibleNodes do: [ :node |
		  node isEnabled ifTrue: [
			  | mitem |
			  mitem := ToMenuItem new
				           labelText: node item label text asString;
				           whenClickedDo: [ :event |
					           aTabsElement itemBar selecter
						           scrollTowardStartToDataSourcePosition:
							           node holder position.
					           aTabsElement requestFocus.
					           node item checked: true ];
				           yourself.
			  node item isChecked ifTrue: [
				  mitem icon:
					  (ToImage inner: (aTabsElement valueOfTokenNamed: #check)).
				  mitem icon size:
					  (aTabsElement valueOfTokenNamed: #'checkable-icon-size') ].
			  menu addItem: mitem ] ].
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
