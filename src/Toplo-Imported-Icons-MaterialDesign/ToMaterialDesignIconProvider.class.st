Class {
	#name : #ToMaterialDesignIconProvider,
	#superclass : #ToImportedIconProvider,
	#category : #'Toplo-Imported-Icons-MaterialDesign'
}

{ #category : #'_code generating' }
ToMaterialDesignIconProvider class >> listElementWithAllIcons [

	| l  |
	l := ToListElement new.
	l withRowNumbers.
	l selectionMode beneathOption: ToListSelectionOption none.
	l selectionMode overOption: ToListSelectionOption grouped.

	self subclassesDo: [ :providerCls |
		ToIconStyle allSubclassesDo: [ :styleCls |
			| s |
			s := #'_loaded'.
			l dataAccessor addAll: ((providerCls perform: s) collect: [:n | n -> (providerCls -> styleCls) ]) ] ].

	l nodeBuilder: [ :node :holder |
		| styleCls typeLab typePane iclab iclabPane imPane providerCls iconName |
		providerCls := holder dataItem value key.
		styleCls := holder dataItem value value.
		iconName := holder dataItem key.
		node layout: BlLinearLayout horizontal.
		iclabPane := ToPane new layout: BlFrameLayout new.
		iclabPane withNullSkin.
		iclabPane vFitContent.
		iclabPane width: 150.
		typePane := ToPane new layout: BlFrameLayout new.
		typePane withNullSkin.
		typePane vFitContent.
		typePane width: 150.
		iclab := ToLabel text: iconName.
		iclab constraintsDo: [ :c | c frame vertical alignCenter ].
		iclabPane addChild: iclab.
		typeLab := ToLabel text: providerCls _iconType.
		typeLab constraintsDo: [ :c | c frame vertical alignCenter ].
		typePane addChild: typeLab.
		imPane := ToPane new layout: BlFrameLayout new.
		imPane fitContent.
		imPane addChild: ((ToImage inner: (providerCls perform: iconName asSymbol))
				 size: 24 asPoint;
				 yourself).
		node addChildren: {
				typePane.
				iclabPane.
				imPane }.
		node childrenDo: [ :child |
			child constraintsDo: [ :c | c linear vertical alignCenter ] ] ].
	^ l
]
