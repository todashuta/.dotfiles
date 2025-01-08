import type { Entrypoint, Denops } from "jsr:@denops/std@^7.0.0";
import { assert, is } from "jsr:@core/unknownutil@^4.0.0";

export const main: Entrypoint = (denops: Denops) => {
  denops.dispatcher = {
    decodeURIComponent(s: unknown) {
      assert(s, is.String);
      return globalThis.decodeURIComponent(s);
    },
    encodeURIComponent(s: unknown) {
      assert(s, is.String);
      return globalThis.encodeURIComponent(s);
    },
  };
};
