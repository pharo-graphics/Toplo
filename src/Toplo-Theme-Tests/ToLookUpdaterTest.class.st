Class {
	#name : #ToLookUpdaterTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-LookUpdater'
}

{ #category : #tests }
ToLookUpdaterTest >> monospacedFontFamilyName [
		
	^ 'Source Code Pro'
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterFailsWithExplicitPropertyWithWrongWriter [
	" a ToElement DNU #fontName: "

	| w updater installEvent prop |
	w := ToElement new.
	prop := ToExplicitPropertyDef new name: #'font-name'.
	prop writer: [ :e :v | e fontName: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.

	installEvent := ToInstallLookEvent new currentTarget: w.
	self should: [ updater announceLookEvent: installEvent ] raise: MessageNotUnderstood
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterNeedPropertyForValueUpdating [

	| w updater  |

	w := ToElement new.

	updater := ToLookUpdater new property: nil.
	updater when: ToInstallLookEvent do: [ :e | e background: Color white ].
	self should: [ updater when: ToInstallLookEvent value: Color white ] raise: Error
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithExplicitProperty [

	| w updater installEvent prop |

	w := ToElement new.
	prop := ToExplicitPropertyDef new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.

	installEvent := ToInstallLookEvent new currentTarget: w..
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithExplicitPropertyFor3StatesWithRawValue [

	| w updater installEvent prop hoveredEvent leavedEvent |

	w := ToElement new.
	prop := ToExplicitPropertyDef new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.
	updater when: ToHoveredLookEvent value: Color red.
	updater when: ToLeavedLookEvent value: Color gray.

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white.
	
	hoveredEvent := ToHoveredLookEvent new currentTarget: w.
	updater announceLookEvent: hoveredEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color red.
	
	leavedEvent := ToLeavedLookEvent new currentTarget: w.
	updater announceLookEvent: leavedEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color gray
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithExplicitPropertyFor3StatesWithValuable [

	| w updater installEvent prop hoveredEvent leavedEvent |

	w := ToElement new.
	prop := ToExplicitPropertyDef new.
	prop writer: [ :e :v | e background: v ].

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: [:e | Color white].
	updater when: ToHoveredLookEvent value: [:e | Color red].
	updater when: ToLeavedLookEvent value: [:e | Color gray].

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white.
	
	hoveredEvent := ToHoveredLookEvent new currentTarget: w.
	updater announceLookEvent: hoveredEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color red.
	
	leavedEvent := ToLeavedLookEvent new currentTarget: w.
	updater announceLookEvent: leavedEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color gray
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithInheritedProperty [

	| w updater installEvent prop |

	w := ToElement new.
	prop := ToInheritedPropertyDef new name: #background.

	updater := ToLookUpdater new property: prop.
	updater when: ToInstallLookEvent value: Color white.

	installEvent := ToInstallLookEvent new currentTarget: w..
	updater announceLookEvent: installEvent.
	" no parent -> inherited property def lookup fails -> no write"
	self assert: (w background isKindOf: BlTransparentBackground)
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithInheritedProperty2 [

	| child parentUpdater installEvent parent parentSkin childSkin childUpdater parentProp childProp |

	parent := ToElement new.
	parentProp := ToInstVarPropertyDef new name: #background.
	parentUpdater := ToLookUpdater new property: parentProp.
	parentUpdater when: ToInstallLookEvent value: Color white.
	parentSkin := ToWidgetSkin new.
	parentSkin addLookUpdater: parentUpdater.
	parent withSkin: parentSkin.
	
	child := ToElement new.
	childProp := ToInheritedPropertyDef new name: #background.
	childUpdater := ToLookUpdater new property: childProp.
	parentUpdater when: ToInstallLookEvent value: Color white.
	childSkin := ToWidgetSkin new.
	childSkin addLookUpdater: childUpdater.
	child withSkin: childSkin.

	parent addChild: child.

	installEvent := ToInstallLookEvent new currentTarget: child.
	childUpdater announceLookEvent: installEvent.
	self assert: (child background isKindOf: BlPaintBackground)
]

{ #category : #tests }
ToLookUpdaterTest >> testLookUpdaterWithoutProperty [

	| w updater installEvent |
	w := ToElement new.
	updater := ToLookUpdater new.
	updater when: ToInstallLookEvent do: [ :e | e background: Color white ].

	installEvent := ToInstallLookEvent new currentTarget: w.
	updater announceLookEvent: installEvent.
	self assert: (w background isKindOf: BlPaintBackground).
	self assert: w background paint color equals: Color white
]
