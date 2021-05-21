package com.rawchen.util.markdown.ext.cover.internal;

import com.rawchen.util.markdown.ext.cover.Cover;
import org.commonmark.node.Node;
import org.commonmark.renderer.NodeRenderer;

import java.util.Collections;
import java.util.Set;

abstract class AbstractCoverNodeRenderer implements NodeRenderer {
	@Override
	public Set<Class<? extends Node>> getNodeTypes() {
		return Collections.<Class<? extends Node>>singleton(Cover.class);
	}
}
